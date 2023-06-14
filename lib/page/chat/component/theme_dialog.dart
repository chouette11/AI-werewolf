import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstant.base,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        height: 360,
        width: 240,
        child: Center(
          child: Column(
            children: [
              const Text('あなたは', style: TextStyleConstant.normal16),
              const SizedBox(height: 8),
              const Text('ユーザー1(一般人)', style: TextStyleConstant.bold24),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Spacer(),
                  Text('お題', style: TextStyleConstant.normal18),
                  Spacer(),
                  Text('うどん', style: TextStyleConstant.bold28),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 100,
                width: 200,
                child: TextField(
                  cursorColor: ColorConstant.main,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.main,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.main,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: '解答を入力してください',
                    hintStyle: TextStyleConstant.normal16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                width: 80,
                child: ElevatedButton(
                  onPressed: () {}, //textfieldに入力された値を送信する
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.main,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    '送信',
                    style: TextStyleConstant.bold14
                        .copyWith(color: ColorConstant.black100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
