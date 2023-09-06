import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/member_repository.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';

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
        final livingMem =
            ref.read(memberRepositoryProvider).getLivingMembers(data);
        // プレイヤーxのxでソート
        livingMem.sort((a, b) => a.assignedId.compareTo(b.assignedId));
        return room.when(
          data: (room) {
            return AlertDialog(
              backgroundColor: ColorConstant.back,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '誰を処刑しますか？',
                    style: TextStyleConstant.normal20,
                  ),
                  ...livingMem
                      .map(
                        (member) => ListTile(
                          title: Text(
                            'プレイヤー${member.assignedId}',
                            style: TextStyleConstant.normal16,
                          ),
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
                  isSend
                      ? Text(
                          '全員が投票するまでおまちください',
                          style: TextStyleConstant.normal12
                              .copyWith(color: ColorConstant.accent),
                        )
                      : const SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: value == '' || isSend
                        ? null
                        : () {
                            ref.read(memberRepositoryProvider).voteForMember(
                                widget.roomId, value[value.length - 1]);
                            isSend = true;
                            setState(() {});
                          },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ColorConstant.main,
                      backgroundColor: ColorConstant.accent,
                    ),
                    child: const Text('決定'),
                  ),
                ],
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
