import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class CorrectDialog extends StatelessWidget {
  const CorrectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    String correct = '正解';
    String answer = 'ユーザー１';
    return AlertDialog(
      backgroundColor: ColorConstant.black100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        height: 320,
        width: 240,
        child: Center(
          child: Column(
            children: [
              Text(
                correct,
                style: TextStyleConstant.bold28,
              ),
              const SizedBox(height: 40),
              const Text(
                'AIなのは',
                style: TextStyleConstant.normal24,
              ),
              Text(answer, style: TextStyleConstant.normal24),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.main),
                onPressed: () => context.push('/'),
                child: Text(
                  '終了',
                  style: TextStyleConstant.bold16
                      .copyWith(color: ColorConstant.black100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
