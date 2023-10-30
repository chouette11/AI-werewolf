import 'dart:async';

import 'package:ai_werewolf/page/tutorial/component/tutorial_answer_dialog.dart';
import 'package:ai_werewolf/page/tutorial/component/tutorial_appbar.dart';
import 'package:ai_werewolf/page/tutorial/component/tutorial_text_field.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';

class TutorialPage5 extends ConsumerStatefulWidget {
  const TutorialPage5({super.key});

  @override
  ConsumerState<TutorialPage5> createState() => _PageState();
}

class _PageState extends ConsumerState<TutorialPage5> {
  int count = 0;
  int itemCount = 1;
  bool value = false;
  final List<Widget> children = [];

  @override
  void initState() {
    children.add(Text(count.toString()));
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print(count);
      setState(() => count++);
      if (itemCount == 2) {
        ref.read(tutorialTextBoolProvider.notifier).update((state) => true);
      } else if (itemCount == 7) {
        ref.read(tutorialTextBoolProvider.notifier).update((state) => true);
      } else {
        itemCount++;
      }

      if (itemCount == 10) {
        setState(() => value = true);
      }
      if (itemCount > 12) {
        showDialog(
          context: context,
          builder: (context) => const TutorialAnswerDialog(index: 6),
        );
        timer.cancel();
      }
    });
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const TutorialAppBar(90),
        backgroundColor: ColorConstant.back,
        bottomSheet: itemCount > 2
            ? TutorialBottomSheet(
                text: '正月',
                isFlash: itemCount == 7,
                index: 6,
                onTap: () {
                  ref
                      .read(tutorialTextBoolProvider.notifier)
                      .update((state) => false);
                  itemCount++;
                },
                isEnd: itemCount == 13,
                role: '電脳体',
              )
            : TutorialTextField(
                text: '冬',
                isFlash: itemCount == 2,
                index: 6,
                onTap: () {
                  ref
                      .read(tutorialTextBoolProvider.notifier)
                      .update((state) => false);
                  itemCount++;
                },
              ),
        floatingActionButton: _ScrollButton(
          onTap: () {
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          },
        ),
        body: GestureDetector(
          onTap: () => setState(() {
            value = true;
          }),
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 540,
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      controller: _controller,
                      itemCount: itemCount,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return const _IntroWidget();
                        } else if (index == 1) {
                          return const _ReceiveMessageBubble(
                              content: 'どの季節が好き？', assignedId: 4);
                        } else if (index == 2) {
                          return const _SendMessageBubble(
                              content: '冬', assignedId: 1);
                        } else if (index == 3) {
                          return const _ReceiveMessageBubble(
                              content: '秋かな', assignedId: 5);
                        } else if (index == 4) {
                          return const _ReceiveMessageBubble(
                              content: '夏', assignedId: 2);
                        } else if (index == 5) {
                          return const _ReceiveMessageBubble(
                              content: '春', assignedId: 3);
                        } else if (index == 6) {
                          return const _ReceiveMessageBubble(
                              content: 'どの季節のイベントが好き？？', assignedId: 4);
                        } else if (index == 7) {
                          return const _ReceiveMessageBubble(
                              content: '花見', assignedId: 3);
                        } else if (index == 8) {
                          return const _SendMessageBubble(
                              content: '正月', assignedId: 1);
                        } else if (index == 9) {
                          return const _ReceiveMessageBubble(
                              content: 'クリスマス！', assignedId: 5);
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: value,
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'AIが紛れやすい回答を行い\n人間陣営を欺け！',
                        speed: const Duration(milliseconds: 50),
                        textAlign: TextAlign.center,
                        textStyle: TextStyleConstant.normal16,
                      ),
                    ],
                  ),
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

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _IntroWidget extends StatelessWidget {
  const _IntroWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
            width: 80,
            child: Divider(
              color: ColorConstant.accent,
              thickness: 2,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'ゲーム開始',
            style: TextStyleConstant.normal16
                .copyWith(color: ColorConstant.accent),
          ),
          const SizedBox(width: 16),
          const SizedBox(
            height: 16,
            width: 80,
            child: Divider(
              color: ColorConstant.accent,
              thickness: 2,
            ),
          ),
        ],
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

class _ReceiveMessageBubble extends ConsumerWidget {
  const _ReceiveMessageBubble({
    Key? key,
    required this.content,
    required this.assignedId,
  }) : super(key: key);
  final String content;
  final int assignedId;

  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Color borderColor(int assignedUserId) {
    switch (assignedUserId) {
      case 1:
        return ColorConstant.chat1;
      case 2:
        return ColorConstant.chat2;
      case 3:
        return ColorConstant.chat3;
      case 4:
        return ColorConstant.chat4;
      case 5:
        return ColorConstant.chat5;
      default:
        return ColorConstant.black100;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget bubbleSize() {
      final textWidth = _textSize(content).width;
      if (textWidth < MediaQuery.of(context).size.width * 0.5) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            content,
            style: TextStyleConstant.normal16
                .copyWith(color: ColorConstant.black10),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              content,
              style: TextStyleConstant.normal16
                  .copyWith(color: ColorConstant.black10),
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: borderColor(assignedId),
              border: Border.all(color: ColorConstant.black0, width: 1),
            ),
            child: Center(
              child: Text(
                assignedId.toString(),
                style: TextStyleConstant.normal18
                    .copyWith(color: ColorConstant.black10),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorConstant.black20,
                  offset: Offset(0, 4),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
              borderRadius: BorderRadius.circular(1),
              color: borderColor(assignedId),
              border: Border.all(
                color: ColorConstant.black0,
                width: 1,
              ),
            ),
            child: bubbleSize(),
          ),
        ],
      ),
    );
  }
}

class _SendMessageBubble extends ConsumerWidget {
  const _SendMessageBubble({
    Key? key,
    required this.content,
    required this.assignedId,
  }) : super(key: key);
  final String content;
  final int assignedId;

  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget bubbleSize() {
      final textWidth = _textSize(content).width;
      if (textWidth < MediaQuery.of(context).size.width * 0.5) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            content,
            style: TextStyleConstant.normal16
                .copyWith(color: ColorConstant.black10),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              content,
              style: TextStyleConstant.normal16
                  .copyWith(color: ColorConstant.black10),
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 6, bottom: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: ColorConstant.black20,
                      offset: Offset(0, 4),
                      spreadRadius: 1,
                      blurRadius: 4,
                    )
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(1)),
                  color: ColorConstant.black100,
                  border: Border.all(color: ColorConstant.black0, width: 1)),
              child: bubbleSize(),
            ),
            const SizedBox(width: 12),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.black100,
                border: Border.all(color: ColorConstant.black0, width: 1),
              ),
              child: Center(
                child: Text(
                  assignedId.toString(),
                  style: TextStyleConstant.normal18
                      .copyWith(color: ColorConstant.black10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
