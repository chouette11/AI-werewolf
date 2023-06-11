import 'package:flutter/material.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';

import 'component/receive_message_bubble.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myOpp = ["aaaa", "bbbb", "cccc"];
    final oppMy = ["dddd", "eeee", "ffff"];
    return Scaffold(
      appBar: AppBar(title: const Text("お題はうどん")),
      bottomSheet: const BottomTextField(),
      body: ListView.builder(
        reverse: true,
        itemCount: myOpp.length + oppMy.length,
        itemBuilder: (BuildContext context, int index) {
          final messages = [...myOpp, ...oppMy];
          final message = messages[index];
          if (index > 2) {
            return SendMessageBubble(message: message);
          } else {
            return ReceiveMessageBubble(message: message);
          }
        },
      ),
    );
  }
}
