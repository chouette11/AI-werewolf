import 'dart:async';

import 'package:ai_werewolf/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_werewolf/page/wait/component/polygon.dart';
import 'package:ai_werewolf/provider/audio_provider.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/play.dart';

class OnlineWaitPage extends ConsumerStatefulWidget {
  const OnlineWaitPage({
    Key? key,
    required this.isJoin,
  }) : super(key: key);
  final bool isJoin;

  @override
  ConsumerState<OnlineWaitPage> createState() => _MakeRoomPageState();
}

class _MakeRoomPageState extends ConsumerState<OnlineWaitPage> {
  int count = 100;
  bool isLoading = false;

  @override
  void initState() {
    Future(() async {
      if (kIsWeb && !widget.isJoin) {
        await ref.read(roomRepositoryProvider).joinRoom("widget.roomId");
      }
    });
    final path = ref.read(waitSoundProvider);
    play(ref, path);
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() => count--);
      }
      if (count < 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStreamProvider);
    return user.when(
      data: (data) {
        if (data.roomId != null) {
          Future.delayed(const Duration(seconds: 1));
          // ウェイティングリストから削除
          ref.read(userRepositoryProvider).removeWaiting(data);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/chat/${data.roomId}/1');
          });
        }
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: ColorConstant.back,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('オンライン', style: TextStyleConstant.bold18),
                const SizedBox(height: 40),
                Text(isLoading ? '役職割り当て中...' : 'マッチング中...',
                    style: TextStyleConstant.normal28),
                const SizedBox(height: 48),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: '${1}',
                          style: TextStyleConstant.bold32),
                      WidgetSpan(child: SizedBox(width: 8)),
                      TextSpan(
                          text: '/', style: TextStyleConstant.normal32),
                      WidgetSpan(child: SizedBox(width: 8)),
                      TextSpan(
                          text: '4', style: TextStyleConstant.normal24),
                      WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                          text: '人', style: TextStyleConstant.normal18),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_outline,
                        color: ColorConstant.main, size: 40),
                    const SizedBox(width: 32),
                    PolygonWidget(0, count),
                    const SizedBox(width: 16),
                    PolygonWidget(1, count),
                    const SizedBox(width: 16),
                    PolygonWidget(2, count),
                    const SizedBox(width: 32),
                    const Icon(Icons.group_outlined,
                        color: ColorConstant.main, size: 40),
                  ],
                )
              ],
            ),
          ),
        );
      },
      error: (_, __) => Text(_.toString()),
      loading: () => const Scaffold(backgroundColor: ColorConstant.back),
    );
  }
}
