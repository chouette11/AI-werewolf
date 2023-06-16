import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/page/chat/component/correct_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

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

    return members.when(
      data: (data) {
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
                const Text('誰がAI？'),
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        final gpt = data[data.indexWhere((e) => e.userId == 'gpt')];
                        return CorrectDialog(
                          gptAssignedId: gpt.assignedId,
                          isCorrect: value[value.length - 1] == gpt.assignedId,
                          roomId: roomId,
                        );
                      },
                    );
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
  }
}
