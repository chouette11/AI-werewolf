import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

import 'component/receive_message_bubble.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("お題はうどん")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(messagesProvider.notifier).addMessage("aaaa");
        },
        child: const Icon(Icons.add),
      ),
      bottomSheet: const BottomTextField(),
      body: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          messages.sort((a, b) {
            //sorting in descending order
            return b.createdAt.compareTo(a.createdAt);
          });
          final message = messages[index];
          if (message.userId == "my") {
            return SendMessageBubble(message: message.content);
          } else {
            return ReceiveMessageBubble(message: message.content);
          }
        },
      ),
    );
  }
}
