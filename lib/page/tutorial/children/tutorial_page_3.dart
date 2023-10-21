import 'package:ai_werewolf/page/result/component/back_title_button.dart';
import 'package:ai_werewolf/page/tutorial/component/tutorial_result_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:confetti/confetti.dart';

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
  late ConfettiController controller;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.play();
    return Scaffold(
      backgroundColor: ColorConstant.back,
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Visibility(
              visible: widget.isWin,
              child: ConfettiWidget(
                confettiController: controller,
                blastDirection: 0,
                emissionFrequency: 0.1,
                numberOfParticles: 10,
                gravity: 1,
                colors: const [ColorConstant.black100, ColorConstant.accent],
                blastDirectionality: BlastDirectionality.explosive,
                minBlastForce: 10,
                shouldLoop: true,
              ),
            ),
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
                const TutorialResultUsers(),
                const SizedBox(height: 48),
                BackTitleButton(
                  onTap: () async {
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
