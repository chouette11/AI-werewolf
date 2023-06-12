import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/page/root/component/join_dialog.dart';
import 'package:wordwolf/page/root/component/start_dialog.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  final String id = "1234567890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "ワードウルフ",
              style: TextStyleConstant.bold28,
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 48,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const StartDialog();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorConstant.main,
                  backgroundColor: ColorConstant.main,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "部屋作成",
                  style: TextStyleConstant.white24,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const JoinDialog();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorConstant.secondary,
                  backgroundColor: ColorConstant.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "参加する",
                  style: TextStyleConstant.normal24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
