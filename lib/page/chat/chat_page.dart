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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref
                .read(messageRepositoryProvider)
                .addMessageFromGpt("aaaa", "0000");
            // ref.read(messagesProvider.notifier).addMessage("aaaa");
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: ColorConstant.main,
          centerTitle: true,
          title: const Text(
            "お題はうどん",
            style: TextStyle(color: ColorConstant.base, fontSize: 16),
          ),
          automaticallyImplyLeading: false,
        ),
        bottomSheet: const BottomTextField(),
        body: messages.when(
          data: (data) {
            return ListView.builder(
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
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
