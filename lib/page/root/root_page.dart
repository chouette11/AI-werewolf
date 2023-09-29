import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:ai_werewolf/page/root/component/main_button.dart';
import 'package:ai_werewolf/page/root/component/title_icon.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/page/root/component/join_dialog.dart';

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
