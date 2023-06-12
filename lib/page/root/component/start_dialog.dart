import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/repository/room_repository.dart';

class StartDialog extends ConsumerWidget {
  const StartDialog({super.key, required this.roomId});
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: ColorConstant.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        width: 240,
        height: 160,
        child: Column(
          children: [
            const Text(
              'ID',
              style: TextStyleConstant.normal32,
            ),
            const SizedBox(height: 16),
            Text(
              roomId,
              style: TextStyleConstant.normal32,
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
            height: 48,
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: roomId));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('テキストがクリップボードに保存されました'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "コピー",
                style: TextStyleConstant.normal16.copyWith(
                  color: ColorConstant.base,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: SizedBox(
            height: 48,
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                ref.read(roomRepositoryProvider).makeRoom(roomId);
                context.push("/chat", extra: roomId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "参加する",
                style: TextStyleConstant.normal16.copyWith(
                  color: ColorConstant.base,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
