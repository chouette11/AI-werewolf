import 'package:ai_werewolf/page/tutorial/component/tutorial_executed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';

class TutorialAnswerDialog extends ConsumerStatefulWidget {
  const TutorialAnswerDialog({super.key});

  @override
  ConsumerState<TutorialAnswerDialog> createState() =>
      _TutorialAnswerDialogState();
}

class _TutorialAnswerDialogState extends ConsumerState<TutorialAnswerDialog> {
  bool isSend = false;
  final ids = [1, 2, 3, 4, 5];
  int selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: ColorConstant.back,
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  ...ids
                      .map((id) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    selectedId = id;
                                    setState(() {});
                                  },
                                  child: _ChoicesWidget(
                                    assignedId: id,
                                    selectedId: selectedId,
                                  )),
                              const SizedBox(height: 16)
                            ],
                          ))
                      .toList(),
                  isSend
                      ? Text(
                          '全員が投票するまでおまちください',
                          style: TextStyleConstant.normal12
                              .copyWith(color: ColorConstant.accent),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      isSend = true;
                      showDialog<void>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return TutorialExecutedDialog(id: selectedId);
                        },
                      );
                    },
                    child: Container(
                      width: 56,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: ColorConstant.accent,
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstant.black10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Text(
                        '決定',
                        style: TextStyleConstant.normal12,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset('assets/images/vote.png')
        ],
      ),
    );
  }
}

class _ChoicesWidget extends ConsumerWidget {
  const _ChoicesWidget({
    Key? key,
    required this.assignedId,
    required this.selectedId,
  }) : super(key: key);
  final int assignedId;
  final int selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 40,
          width: 200,
          child: Stack(
            children: [
              Positioned(
                top: 2,
                right: 0,
                child: SizedBox(child: Image.asset('assets/images/shadow.png')),
              ),
              assignedId == selectedId
                  ? Image.asset('assets/images/selected.png')
                  : Image.asset('assets/images/not_selected.png'),
            ],
          ),
        ),
        SizedBox(
          height: 32,
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.black90,
                    ),
                    width: 16.5,
                    height: 16.5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getChatColor(assignedId),
                    ),
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
              Text(
                'プレイヤー$assignedId',
                style: TextStyleConstant.normal16.copyWith(
                  color: ColorConstant.black0,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
