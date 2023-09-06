import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/page/chat/component/role_dialog.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/model/entity/room/room_entity.dart';
import 'package:wordwolf/page/chat/component/answer_dialog.dart';
import 'package:wordwolf/page/chat/component/bottom_field.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/chat_appbar.dart';
import 'package:wordwolf/page/chat/component/executed_dialog.dart';
import 'package:wordwolf/page/chat/component/receive_message_bubble.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/member_repository.dart';

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

  Future<void> _showExecutedDialog(RoomEntity room, bool isMake) async {
    final livingMem = await ref
        .read(memberRepositoryProvider)
        .getLivingMembersFromDB(widget.roomId);
    if (!livingMem.map((e) => e.userId).contains(ref.read(uidProvider))) {
      return;
    }
    // gptの分を引く
    if (room.votedSum == livingMem.length - 1) {
      if (isMake) {
        /// 投票数が多い人間を処刑
        livingMem.sort((a, b) => -a.voted.compareTo(b.voted));
        final mem = livingMem[0];
        await ref.read(memberRepositoryProvider).killMember(
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => RoleDialog(widget.roomId, false),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesStreamProvider(widget.roomId));
    final counter = ref.watch(limitTimeProvider);
    final uid = ref.watch(uidProvider);
    final room = ref.watch(roomStreamProvider(widget.roomId));
    final isMake = ref.watch(isMakeRoomProvider);

    if (counter < 0 && !isDialog) {
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

    ScrollController _controller = ScrollController();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: ChatAppBar(roomId: widget.roomId),
        backgroundColor: ColorConstant.back,
        floatingActionButton: SizedBox(
          height: 100,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _controller.animateTo(
                    _controller.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  height: 40,
                  width: 40,
                  color: ColorConstant.accent,
                  child: const Icon(Icons.arrow_downward_sharp, size: 28),
                ),
              ),
            ],
          ),
        ),
        body: messages.when(
          data: (data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ScrollConfiguration(
                    behavior: NoEffectScrollBehavior(),
                    child: ListView.builder(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 16,
                                  width: 80,
                                  child: Divider(
                                    color: ColorConstant.accent,
                                    thickness: 2,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'ゲーム開始',
                                  style: TextStyleConstant.normal16
                                      .copyWith(color: ColorConstant.accent),
                                ),
                                const SizedBox(width: 16),
                                const SizedBox(
                                  height: 16,
                                  width: 80,
                                  child: Divider(
                                    color: ColorConstant.accent,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        data.sort((a, b) {
                          //sorting in descending order
                          return a.createdAt.compareTo(b.createdAt);
                        });
                        final message = data[index - 1];
                        if (message.userId == uid) {
                          return SendMessageBubble(
                            messageEntity: message,
                            roomId: widget.roomId,
                          );
                        } else {
                          return ReceiveMessageBubble(
                            messageEntity: message,
                            roomId: widget.roomId,
                          );
                        }
                      },
                    ),
                  ),
                ),
                counter <= 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: BottomField(roomId: widget.roomId),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: BottomTextField(roomId: widget.roomId),
                      ),
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

class NoEffectScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
