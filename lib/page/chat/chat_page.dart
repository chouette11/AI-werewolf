import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/receive_message_bubble.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({
    super.key,
    required this.roomId,
  });
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesStreamProvider(roomId));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(messageRepositoryProvider).addMessageFromGpt("aaaa", roomId);
          // ref.read(messagesProvider.notifier).addMessage("aaaa");
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: ColorConstant.black100,
        centerTitle: true,
        title: const Text(
          "お題はうどん",
          style: TextStyleConstant.bold14,
        ),
        automaticallyImplyLeading: false,
      ),
      bottomSheet: BottomTextField(roomId: roomId),
      body: messages.when(
        data: (data) {
          return SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewInsets.bottom -
                180,
            child: ListView.builder(
              reverse: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                data.sort((a, b) {
                  //sorting in descending order
                  return b.createdAt.compareTo(a.createdAt);
                });
                final message = data[index];
                if (message.userId == "my") {
                  return SendMessageBubble(message: message.content);
                } else {
                  return ReceiveMessageBubble(message: message.content);
                }
              },
            ),
          );
        },
        error: (error, stackTrace) {
          return Text(error.toString());
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
