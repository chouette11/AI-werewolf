import 'dart:async';

import 'package:ai_werewolf/page/result/component/back_title_button.dart';
import 'package:ai_werewolf/page/tutorial/component/tutorial_result_users.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:go_router/go_router.dart';

class TutorialPage6 extends ConsumerStatefulWidget {
  const TutorialPage6({
    required this.isWin,
    Key? key,
  }) : super(key: key);
  final bool isWin;

  @override
  ConsumerState<TutorialPage6> createState() => _TutorialPage6State();
}

class _TutorialPage6State extends ConsumerState<TutorialPage6> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print(count);
      setState(() => count++);
      if (count > 5) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.back,
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '電脳体',
                  style: TextStyleConstant.normal32,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.isWin ? '勝利' : '敗北',
                  style: TextStyleConstant.bold60,
                ),
                const Icon(
                  Icons.psychology_outlined,
                  color: ColorConstant.accent,
                  size: 152,
                ),
                const SizedBox(height: 8),
                const TutorialResultUsers(
                  roles: ['電脳体', '人間', 'AI', '人間', '電脳体'],
                ),
                const SizedBox(height: 32),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '今回も3番がAIでした。\n電脳体陣営はこの3番を処刑から守ることで\n勝利になります。',
                      textAlign: TextAlign.center,
                      textStyle: TextStyleConstant.normal16,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  reverseDuration: const Duration(milliseconds: 800),
                  child: count > 2
                      ? ArrowButton(
                          key: const Key('1'),
                          title: 'タイトルに戻る',
                          onTap: () => context.go('/'),
                        )
                      : const SizedBox(
                          key: Key('2'),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
