import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class BottomField extends StatelessWidget {
  const BottomField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: ColorConstant.secondary,
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
              onPressed: () {context.push('/correct');},
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
    );
  }
}
