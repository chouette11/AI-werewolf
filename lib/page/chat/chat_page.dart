import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/entity/room/room_entity.dart';
import 'package:wordwolf/page/chat/component/answer_dialog.dart';
import 'package:wordwolf/page/chat/component/bottom_field.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/chat_appbar.dart';
import 'package:wordwolf/page/chat/component/executed_dialog.dart';
import 'package:wordwolf/page/chat/component/receive_message_bubble.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';
import 'package:wordwolf/page/chat/component/theme_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({
    super.key,
    required this.roomId,
    this.isFirst = true,
  });

  final String roomId;
  final bool isFirst;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  bool isDialog = false;

  Future<void> _showStartDialog() async {
    final room = await ref.read(roomRepositoryProvider).getRoom(widget.roomId);
    final livingMem = await ref
        .read(roomRepositoryProvider)
        .getLivingMembersFromDB(widget.roomId);
    if (!livingMem.map((e) => e.userId).contains(ref.read(uidProvider))) {
      return;
    }
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ThemeDialog(
          widget.roomId,
          widget.isFirst ? room.maxNum : livingMem.length,
        );
      },
    );
  }

  Future<void> _showExecutedDialog(RoomEntity room, bool isMake) async {
    final livingMem = await ref
        .read(roomRepositoryProvider)
        .getLivingMembersFromDB(widget.roomId);
    if (!livingMem.map((e) => e.userId).contains(ref.read(uidProvider))) {
      return;
    }
    // gptの分を引く
    if (room.votedSum == livingMem.length - 1) {
      if (isMake) {
        livingMem.sort((a, b) => -a.voted.compareTo(b.voted));
        final mem = livingMem[0];
        await ref.read(roomRepositoryProvider).killMember(
              widget.roomId,
              mem.userId,
            );
      }
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ExecutedDialog(roomId: room.id, members: livingMem);
        },
      );
    }
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
    final room = ref.watch(roomStreamProvider(widget.roomId));
    final isMake = ref.watch(isMakeRoomProvider);

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

    room.whenData((value) => _showExecutedDialog(value, isMake));

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: ChatAppBar(roomId: widget.roomId),
        body: messages.when(
          data: (data) {
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
