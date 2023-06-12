import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

final userList = [
  'Lafayette',
  'Thomas Jefferson',
];

class AnswerDialog extends ConsumerWidget {
  const AnswerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(answerRadioValueProvider);

    return AlertDialog(
      backgroundColor: ColorConstant.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        width: 240,
        height: 160,
        child: Column(
          children: [
            const Text('誰がAI？'),
            ListTile(
              title: const Text('Lafayette'),
              leading: Radio<String>(
                value: userList[0],
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
            ListTile(
              title: const Text('Thomas Jefferson'),
              leading: Radio<String>(
                value: userList[1],
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
            ElevatedButton(onPressed: () {}, child: const Text('決定')),
          ],
        ),
      ),
    );
  }
}
