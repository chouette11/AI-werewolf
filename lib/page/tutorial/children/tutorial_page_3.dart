import 'dart:async';

import 'package:ai_werewolf/page/result/component/back_title_button.dart';
import 'package:ai_werewolf/page/tutorial/component/tutorial_result_users.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:go_router/go_router.dart';

class TutorialPage3 extends ConsumerStatefulWidget {
  const TutorialPage3({
    Key? key,
    required this.isWin,
  }) : super(key: key);
  final bool isWin;

  @override
  ConsumerState<TutorialPage3> createState() => _TutorialPage3State();
}

class _TutorialPage3State extends ConsumerState<TutorialPage3> {
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
      body: Container(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '人間',
                    style: TextStyleConstant.normal32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isWin ? '勝利' : '敗北',
                    style: TextStyleConstant.bold60,
                  ),
                  const Icon(
                    Icons.diversity_3,
                    color: ColorConstant.main,
                    size: 152,
                  ),
                  const SizedBox(height: 8),
                  const TutorialResultUsers(
                    roles: ['人間', '人間', 'AI', '電脳体', '電脳体'],
                  ),
                  const SizedBox(height: 32),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '今回は3番がAIでした。\n人間陣営はこの3番を処刑することで\n勝利になります。',
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
                            title: '次へ',
                            onTap: () => context.push('/tutorial/4'),
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
      ),
    );
  }
}
