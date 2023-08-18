import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';
import 'package:wordwolf/util/constant/color_constant.dart';

class EndDialog extends StatelessWidget {
  const EndDialog({Key? key, required this.result}) : super(key: key);
  final String result;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '勝利',
                  style: TextStyleConstant.normal14,
                ),
                const SizedBox(width: 8),
                Text(result, style: TextStyleConstant.bold18),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.main,
              ),
              onPressed: () {
                context.push("/");
              },
              child: Text(
                '終了',
                style: TextStyleConstant.normal14
                    .copyWith(color: ColorConstant.black100),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
