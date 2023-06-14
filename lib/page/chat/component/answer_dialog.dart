import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/page/chat/component/correct_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

class AnswerDialog extends ConsumerWidget {
  const AnswerDialog({
    super.key,
    required this.memberMap,
    required this.roomId,
  });

  final Map<String, int> memberMap;
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(answerRadioValueProvider);

    List<Widget> listTiles() {
      final List<Widget> tiles = [];
      final nameList = memberMap.values.toList();
      for (var name in nameList) {
        tiles.add(ListTile(
          title: Text(name.toString()),
          leading: Radio<String>(
            activeColor: ColorConstant.main,
            value: name.toString(),
            groupValue: value,
            onChanged: (String? value) {
              if (value != null) {
                ref
                    .read(answerRadioValueProvider.notifier)
                    .update((state) => value);
              }
            },
          ),
        ));
      }
      return tiles;
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
            const Text('誰がAI？'),
            ...listTiles(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return CorrectDialog(
                      answerName: memberMap['gpt'].toString(),
                      isCorrect: value == memberMap['gpt'].toString(),
                      roomId: roomId,
                    );
                  },
                );
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: ColorConstant.main),
              child: const Text('決定'),
            ),
          ],
        ),
      ),
    );
  }
}
