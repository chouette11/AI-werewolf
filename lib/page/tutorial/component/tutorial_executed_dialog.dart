import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';

class TutorialExecutedDialog extends ConsumerWidget {
  const TutorialExecutedDialog({
    required this.id,
    required this.index,
    Key? key,
  }) : super(key: key);
  final int id;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: ColorConstant.back,
        content: SizedBox(
          width: 240,
          height: 200,
          child: Column(
            children: [
              const Text('処刑', style: TextStyleConstant.normal14),
              Text(
                'プレイヤー$id',
                style: TextStyleConstant.normal20,
              ),
              const SizedBox(height: 24),
              Image.asset('assets/images/execute.png'),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  context.pop();
                  context.push('/tutorial/$index', extra: id == 3);
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
                    'OK',
                    style: TextStyleConstant.normal12,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
