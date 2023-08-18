import 'package:flutter/material.dart';
import 'package:wordwolf/model/constant/text_style_constant.dart';
import 'package:wordwolf/model/constant/color_constant.dart';
import 'package:wordwolf/page/chat/component/answer_dialog.dart';

class BottomField extends StatelessWidget {
  const BottomField({super.key, required this.roomId});
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: ColorConstant.accent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Spacer(),
            const Text(
              'あなたはユーザー１（一般人）',
              style: TextStyleConstant.bold12,
            ),
            const Spacer(),
            SizedBox(
              width: 80,
              height: 32,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AnswerDialog(roomId: roomId);
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.main,
                ),
                child: Text(
                  '解答',
                  style: TextStyleConstant.bold12.copyWith(
                    color: ColorConstant.black100,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
