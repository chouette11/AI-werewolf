import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/page/chat/component/answer_dialog.dart';
import 'package:wordwolf/page/chat/component/bottom_field.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/chat_appbar.dart';
import 'package:wordwolf/page/chat/component/receive_message_bubble.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';
import 'package:wordwolf/page/chat/component/theme_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.roomId});
  final String roomId;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  int maxNum = 100;
  bool isDialog = false;

  Future<void> _showStartDialog() async {
    final room = await ref.read(roomRepositoryProvider).getRoom(widget.roomId);
    maxNum = room.maxNum;
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ThemeDialog(widget.roomId, maxNum);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showStartDialog());
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesStreamProvider(widget.roomId));
    final counter = ref.watch(limitTimeProvider);
    final uid = ref.watch(uidProvider);

    if (counter == 0 && !isDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AnswerDialog(
            roomId: widget.roomId,
          ),
        );
        isDialog = true;
      });
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: ChatAppBar(roomId: widget.roomId),
        body: messages.when(
          data: (data) {
            if (data.length < maxNum) {
              return SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    180,
                child: const Center(
                  child: Text('それではゲームを開始します！'),
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
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
                ),
                counter <= 0
                    ? BottomField(roomId: widget.roomId)
                    : BottomTextField(roomId: widget.roomId),
              ],
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
