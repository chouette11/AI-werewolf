import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';

class TutorialTextField extends StatefulWidget {
  const TutorialTextField({super.key, this.text});
  final String? text;

  @override
  State<TutorialTextField> createState() => _TutorialTextFieldState();
}

class _TutorialTextFieldState extends State<TutorialTextField> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _color = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: ColorConstant.back,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black10,
            offset: Offset(0, -0.25),
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(child: _CustomTextBox(1, widget.text ?? '')),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {_controller.forward();},
                child: AnimatedBuilder(
                  animation: _color,
                  builder: (context, child) {
                    return Icon(
                      Icons.send,
                      color: _color.value,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextBox extends ConsumerWidget {
  const _CustomTextBox(this.maxLine, this.text, {Key? key}) : super(key: key);
  final int maxLine;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(tutorialTextBoolProvider);
    return Stack(
      children: [
        TextFormField(
          controller: ref.read(tutorialTextFieldController),
          textAlign: TextAlign.left,
          cursorColor: ColorConstant.black30,
          maxLines: maxLine,
          decoration: const InputDecoration(
            fillColor: ColorConstant.black90,
            filled: true,
            hintText: 'メッセージを入力',
            hintStyle: TextStyle(fontSize: 16, color: ColorConstant.black50),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide.none,
            ),
          ),
          style:
              TextStyleConstant.normal16.copyWith(color: ColorConstant.black30),
        ),
        Visibility(
          visible: value,
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: ColorConstant.black90,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 12),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      text,
                      speed: const Duration(milliseconds: 120),
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                          fontSize: 16, color: ColorConstant.black0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
