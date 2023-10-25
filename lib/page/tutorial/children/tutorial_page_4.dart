import 'package:ai_werewolf/page/tutorial/component/tutorial_appbar.dart';
import 'package:ai_werewolf/page/tutorial/component/tutorial_text_field.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:go_router/go_router.dart';

class TutorialPage4 extends ConsumerWidget {
  const TutorialPage4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool flag = false;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: const TutorialAppBar(120),
          backgroundColor: ColorConstant.back,
          bottomSheet: const TutorialTextField(),
          floatingActionButton: _ScrollButton(onTap: () {}),
          body: GestureDetector(
            onTap: () {
              if (!flag) {
                ref.read(tutorialTextBoolProvider.notifier).update((
                    state) => true);
                flag = true;
                return;
              }
              ref.read(tutorialTextBoolProvider.notifier).update((
                  state) => false);
              context.push('/tutorial/5');
            },
            child: Container(
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
                        'あなたは電脳体陣営\n人間陣営の質問から\nAIを守り切る',
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
