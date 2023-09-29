import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_werewolf/provider/audio_provider.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/member_repository.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/play.dart';

class JoinDialog extends ConsumerWidget {
  const JoinDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(errorTextProvider);
    return AlertDialog(
      backgroundColor: ColorConstant.back,
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
                keyboardType: TextInputType.number,
                cursorColor: ColorConstant.black40,
                decoration: const InputDecoration(
                  fillColor: ColorConstant.black90,
                  filled: true,
                  hintText: 'IDを入力',
                  hintStyle:
                      TextStyle(fontSize: 16, color: ColorConstant.black50),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorConstant.black40,
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

                /// ルームがない場合
                final isRoom =
                    await ref.read(roomRepositoryProvider).isRoom(textValue);
                if (!isRoom) {
                  ref
                      .read(errorTextProvider.notifier)
                      .update((state) => 'ルームが見つかりません');
                  await play(ref, ref.read(notSoundProvider));
                  Timer(const Duration(seconds: 2), () {
                    ref.refresh(errorTextProvider);
                  });
                  return;
                }

                /// ルームが満室の場合
                final isLimit = await ref
                    .read(memberRepositoryProvider)
                    .isLimitMember(textValue);
                if (isLimit) {
                  ref
                      .read(errorTextProvider.notifier)
                      .update((state) => 'ルームが満室です');
                  Timer(const Duration(seconds: 2), () {
                    ref.refresh(errorTextProvider);
                  });
                  return;
                }

                await ref.read(roomRepositoryProvider).joinRoom(textValue);
                context.go("/wait/$textValue/1");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.accent,
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
