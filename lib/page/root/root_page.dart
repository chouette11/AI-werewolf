import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:ai_werewolf/provider/audio_provider.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/page/root/component/join_dialog.dart';
import 'package:ai_werewolf/util/play.dart';
import 'package:ai_werewolf/page/root/component/main_button.dart';
import 'package:ai_werewolf/page/root/component/title_icon.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/page/root/component/join_dialog.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {

  @override
  void initState() {
    final audio = ref.read(audioProvider);
    audio.play(AssetSource('audios/title.mp3'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorConstant.back,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TitleIcon(),
              const SizedBox(height: 80),
              MainButton(
                onTap: () async {
                  final rng = Random();
                  final roomId = rng.nextInt(100000).toString().padLeft(5, '0');
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
                  context.go("/wait/$roomId/1");
                },
                text: '部屋作成',
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
                    ref.read(isMakeRoomProvider.notifier).update((
                        state) => true);
                    const flavor = String.fromEnvironment('flavor');
                    if (flavor == 'tes') {
                      context.go('/chat/$roomId/1');
                      return;
                    }
                    context.go("/wait/$roomId/1");
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
              const SizedBox(height: 32),
              MainButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const JoinDialog();
                    },
                  );
                },
                text: '参加する',
              ),
              const SizedBox(height: 32)
            ],
          ),
        ),
      ),
    );
  }
}
