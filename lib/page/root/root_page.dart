import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/page/root/component/join_dialog.dart';
import 'package:wordwolf/page/root/component/make_dialog.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorConstant.back,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "AI人狼",
                style: TextStyleConstant.bold28,
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 48,
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    final rng = Random();
                    final roomId =
                        rng.nextInt(100000).toString().padLeft(5, '0');
                    showDialog(
                      context: context,
                      builder: (_) {
                        return StartDialog(roomId: roomId);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorConstant.main,
                    backgroundColor: ColorConstant.accent,
                  ),
                  child: const Text("部屋作成", style: TextStyleConstant.normal24),
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
                    foregroundColor: ColorConstant.accent,
                    backgroundColor: ColorConstant.accent,
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
      ),
    );
  }
}
