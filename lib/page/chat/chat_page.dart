import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/page/chat/component/role_dialog.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/model/entity/room/room_entity.dart';
import 'package:ai_werewolf/page/chat/component/answer_dialog.dart';
import 'package:ai_werewolf/page/chat/component/bottom_text_field.dart';
import 'package:ai_werewolf/page/chat/component/chat_appbar.dart';
import 'package:ai_werewolf/page/chat/component/executed_dialog.dart';
import 'package:ai_werewolf/page/chat/component/receive_message_bubble.dart';
import 'package:ai_werewolf/page/chat/component/send_message_bubble.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/member_repository.dart';

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
  final ScrollController _controller = ScrollController();

  Future<void> _showExecutedDialog(RoomEntity room) async {
    final livingMem = await ref
        .read(memberRepositoryProvider)
        .getLivingMembersFromDB(widget.roomId);
    if (!livingMem.map((e) => e.uid).contains(ref.read(uidProvider))) {
      return;
    }
    // gptの分を引く
    if (room.votedSum == livingMem.length - 1) {
      // ignore: use_build_context_synchronously
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

    if (counter <= 0 && !isDialog) {
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

    // 投票数が生きているメンバー数と一致するとき、処刑
    room.whenData((value) => _showExecutedDialog(value));

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: ChatAppBar(roomId: widget.roomId),
          backgroundColor: ColorConstant.back,
          bottomSheet: CustomBottomSheet(
            roomId: widget.roomId,
            counter: counter,
          ),
          floatingActionButton: _ScrollButton(
            onTap: () {
              _controller.animateTo(
                _controller.position.maxScrollExtent,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            },
          ),
          body: messages.when(
            data: (data) {
              return Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: data.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return const _IntroWidget();
                          }
                          if (index == data.length) {
                            _controller.animateTo(
                              _controller.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeInOut,
                            );
                          }
                          data.sort(
                              (a, b) => a.createdAt.compareTo(b.createdAt));
                          final message = data[index - 1];
                          if (message.uid == uid) {
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
                  const SizedBox(height: 80),
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

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _IntroWidget extends StatelessWidget {
  const _IntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class _ScrollButton extends StatelessWidget {
  const _ScrollButton({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: ColorConstant.accent,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.black0,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_downward_sharp, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
