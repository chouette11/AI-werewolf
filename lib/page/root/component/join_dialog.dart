import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class JoinDialog extends ConsumerWidget {
  const JoinDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(errorTextProvider);
    return AlertDialog(
      backgroundColor: ColorConstant.black100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        width: 240,
        height: 160,
        child: Column(
          children: [
            const Text(
              '参加ID',
              style: TextStyleConstant.normal32,
            ),
            const SizedBox(height: 16),
            Text(
              error,
              style: TextStyleConstant.bold14.copyWith(color: Colors.redAccent),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 40,
              width: 224,
              child: TextField(
                onChanged: (value) => ref
                    .watch(idTextFieldProvider.notifier)
                    .update((state) => value),
                textAlign: TextAlign.left,
                autofocus: true,
                cursorColor: ColorConstant.main,
                decoration: const InputDecoration(
                  fillColor: ColorConstant.black90,
                  filled: true,
                  hintText: 'IDを入力',
                  hintStyle:
                      TextStyle(fontSize: 16, color: ColorConstant.black50),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorConstant.black0,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
            height: 48,
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                final textValue = ref.watch(idTextFieldProvider);
                final isRoom =
                    await ref.read(roomRepositoryProvider).isRoom(textValue);
                if (!isRoom) {
                  ref
                      .read(errorTextProvider.notifier)
                      .update((state) => 'ルームが見つかりません');
                  Timer(const Duration(seconds: 2), () {
                    ref.refresh(errorTextProvider);
                  });
                  return;
                }
                final uuid = const Uuid().v4();
                ref.read(uidProvider.notifier).update((state) => uuid);
                await ref.read(roomRepositoryProvider).joinRoom(textValue);
                context.push("/chat", extra: textValue);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "入室する",
                style: TextStyleConstant.normal16.copyWith(
                  color: ColorConstant.black100,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24)
      ],
    );
  }
}
