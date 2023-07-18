import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/page/chat/component/executed_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class AnswerDialog extends ConsumerStatefulWidget {
  const AnswerDialog({super.key, required this.roomId});

  final String roomId;

  @override
  ConsumerState<AnswerDialog> createState() => _AnswerDialogState();
}

class _AnswerDialogState extends ConsumerState<AnswerDialog> {
  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(answerRadioValueProvider);
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final room = ref.watch(roomStreamProvider(widget.roomId));

    return members.when(
      data: (data) {
        final livingMem = ref.read(roomRepositoryProvider).getLivingMembers(data);
        // プレイヤーxのxでソート
        livingMem.sort((a, b) => a.assignedId.compareTo(b.assignedId));
        return room.when(
          data: (room) {
            // 全員等表示遷移
            // gptの分を引く
            if (room.votedSum == livingMem.length - 1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pop();
                showDialog(
                  context: context,
                  builder: (context) => ExecutedDialog(
                    roomId: widget.roomId,
                    members: livingMem,
                  ),
                );
              });
            }
            return AlertDialog(
              backgroundColor: ColorConstant.black100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              content: SizedBox(
                width: 240,
                height: 400,
                child: Column(
                  children: [
                    const Text('誰を処刑しますか？'),
                    ...livingMem
                        .map(
                          (member) => ListTile(
                            title: Text('プレイヤー${member.assignedId}'),
                            leading: Radio<String>(
                              activeColor: ColorConstant.main,
                              value: 'プレイヤー${member.assignedId}',
                              groupValue: value,
                              onChanged: (String? value) {
                                if (value != null) {
                                  ref
                                      .read(answerRadioValueProvider.notifier)
                                      .update((state) => value);
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
                    ElevatedButton(
                      onPressed: value == '' || isSend
                          ? null
                          : () {
                              ref.read(roomRepositoryProvider).voteForMember(
                                  widget.roomId, value[value.length - 1]);
                              isSend = true;
                              setState(() {

                              });
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.main),
                      child: const Text('決定'),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return const Text('エラーが発生しました');
          },
          loading: () => const CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return const Text('エラーが発生しました');
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
