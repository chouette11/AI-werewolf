import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/page/chat/component/executed_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class AnswerDialog extends ConsumerWidget {
  const AnswerDialog({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(answerRadioValueProvider);
    final members = ref.watch(membersStreamProvider(roomId));
    final room = ref.watch(roomStreamProvider(roomId));

    return members.when(
      data: (data) {
        return room.when(
          data: (room) {
            // 全員等表示遷移
            // gptの分を引く
            if (room.votedSum == data.length - 1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pop();
                showDialog(
                  context: context,
                  builder: (context) => ExecutedDialog(
                    roomId: roomId,
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
                    ...data
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
                      onPressed: value == ''
                          ? null
                          : () {
                              ref
                                  .read(roomRepositoryProvider)
                                  .voteForMember(roomId, value[value.length-1]);
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
