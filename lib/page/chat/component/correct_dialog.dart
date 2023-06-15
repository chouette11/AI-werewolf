import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/repository/room_repository.dart';

class CorrectDialog extends ConsumerWidget {
  const CorrectDialog({
    super.key,
    required this.answerName,
    required this.isCorrect,
    required this.roomId,
  });

  final String answerName;
  final bool isCorrect;
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: ColorConstant.black100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        height: 320,
        width: 240,
        child: Center(
          child: Column(
            children: [
              Text(
                isCorrect ? '正解' : '不正解',
                style: TextStyleConstant.bold28,
              ),
              const SizedBox(height: 40),
              const Text(
                'AIは',
                style: TextStyleConstant.normal24,
              ),
              Text('プレイヤー$answerName', style: TextStyleConstant.normal24),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.main),
                onPressed: () async {
                  await ref.read(roomRepositoryProvider).leaveRoom(roomId);
                  context.push('/');
                },
                child: Text(
                  '終了',
                  style: TextStyleConstant.bold16
                      .copyWith(color: ColorConstant.black100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
