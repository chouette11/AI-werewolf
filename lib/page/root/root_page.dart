import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wordwolf/provider/audio_provider.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/page/root/component/join_dialog.dart';
import 'package:wordwolf/util/play.dart';

class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorConstant.back,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "AI人狼",
                style: TextStyleConstant.bold28,
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 48,
                width: 160,
                child: ElevatedButton(
                  onPressed: () async {
                    final rng = Random();
                    final roomId =
                        rng.nextInt(100000).toString().padLeft(5, '0');
                    final uuid = const Uuid().v4();
                    ref.read(uidProvider.notifier).update((state) => uuid);
                    await ref.read(roomRepositoryProvider).makeRoom(roomId, 4);
                    await ref.read(roomRepositoryProvider).joinRoom(roomId);
                    ref.read(isMakeRoomProvider.notifier).update((state) => true);
                    const flavor = String.fromEnvironment('flavor');
                    if (flavor == 'tes') {
                      context.go('/chat/$roomId/1');
                      return;
                    }
                    context.go("/make/$roomId/1");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorConstant.main,
                    backgroundColor: ColorConstant.accent,
                  ),
                  child: const Text("部屋作成", style: TextStyleConstant.normal24),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                width: 160,
                child: ElevatedButton(
                  onPressed: () async {
                    final path = ref.read(buttonSoundProvider);
                    await play(ref, path);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return const JoinDialog();
                        },
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorConstant.main,
                    backgroundColor: ColorConstant.accent,
                  ),
                  child: const Text(
                    "参加する",
                    style: TextStyleConstant.normal24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
