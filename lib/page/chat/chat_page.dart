import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/firestore_data_source.dart';
import 'package:wordwolf/document/message/message_document.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/receive_message_bubble.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';
import 'package:wordwolf/provider/presentation_providers.dart';


class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesStreamProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("お題はうどん")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(firestoreProvider).insertMessage(
              MessageDocument(
                  content: "content",
                  userId: "my",
                  createdAt: DateTime.now()),
              "0000");
          // ref.read(messagesProvider.notifier).addMessage("aaaa");
        },
        child: const Icon(Icons.add),
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
    );
  }
}
