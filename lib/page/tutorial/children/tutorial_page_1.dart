import 'dart:async';

import 'package:ai_werewolf/page/tutorial/component/tutorial_appbar.dart';
import 'package:ai_werewolf/page/tutorial/component/tutorial_text_field.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';

class TutorialPage1 extends ConsumerStatefulWidget {
  const TutorialPage1({super.key});

  @override
  ConsumerState<TutorialPage1> createState() => _PageState();
}

class _PageState extends ConsumerState<TutorialPage1> {
  int count = 0;
  final List<Widget> children = [];

  @override
  void initState() {
    children.add(Text(count.toString()));
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print(count);
      setState(() => count++);
      if (count == 3) {
        ref.read(tutorialTextBoolProvider.notifier).update((state) => true);
      }
      if (count > 5) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: const TutorialAppBar(120),
          backgroundColor: ColorConstant.back,
          bottomSheet: TutorialTextField(
            text: '何うどんが好き？',
            isFlash: count >= 5,
          ),
          floatingActionButton: _ScrollButton(onTap: () {}),
          body: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'あなたは人間陣営\n今から質問をすることによって\nAIを探し出す',
                      textAlign: TextAlign.center,
                      textStyle: TextStyleConstant.normal16,
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollButton extends StatelessWidget {
  const _ScrollButton({required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: ColorConstant.accent,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.black0,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_downward_sharp, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
