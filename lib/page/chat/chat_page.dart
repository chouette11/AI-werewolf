import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/receive_message_bubble.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.roomId});
  final String roomId;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final topic = "うどん";

  @override
  void initState() {
    ref.read(messageRepositoryProvider).addMessageFromGpt(topic, widget.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesStreamProvider(widget.roomId));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(messageRepositoryProvider)
              .addMessageFromGpt("aaaa", widget.roomId);
          // ref.read(messagesProvider.notifier).addMessage("aaaa");
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: ColorConstant.black100,
        centerTitle: true,
        title: Text(
          "お題は$topic",
          style: TextStyleConstant.bold14,
        ),
        automaticallyImplyLeading: false,
      ),
      bottomSheet: BottomTextField(roomId: widget.roomId),
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
    );
  }
}
