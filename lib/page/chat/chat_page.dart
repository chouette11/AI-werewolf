import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/page/chat/component/answer_dialog.dart';
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
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final uid = ref.watch(uidProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: members.when(
          data: (data) {
            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AnswerDialog(
                    memberMap: data,
                    roomId: widget.roomId,
                  ),
                );
              },
              child: const Icon(Icons.add),
            );
          },
          error: (_, __) => FloatingActionButton(onPressed: (){}),
          loading: () => FloatingActionButton(onPressed: (){}),
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
        bottomSheet: BottomTextField(roomId: widget.roomId),
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
                  if (message.userId == uid) {
                    return SendMessageBubble(message: message.content);
                  } else {
                    return ReceiveMessageBubble(
                      messageEntity: message,
                      roomId: widget.roomId,
                    );
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
      ),
    );
  }
}
