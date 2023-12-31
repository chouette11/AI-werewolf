import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ai_werewolf/page/wait/component/polygon.dart';
import 'package:ai_werewolf/provider/audio_provider.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/play.dart';

class WaitPage extends ConsumerStatefulWidget {
  const WaitPage({
    Key? key,
    required this.roomId,
    required this.isJoin,
  }) : super(key: key);
  final String roomId;
  final bool isJoin;

  @override
  ConsumerState<WaitPage> createState() => _MakeRoomPageState();
}

class _MakeRoomPageState extends ConsumerState<WaitPage> {
  int maxNum = 404;
  int count = 100;
  bool isLoading = false;

  @override
  void initState() {
    Future(() async {
      if (kIsWeb && !widget.isJoin) {
        await ref.read(roomRepositoryProvider).joinRoom(widget.roomId);
      }
    });
    final path = ref.read(waitSoundProvider);
    play(ref, path);
    ref
        .read(roomRepositoryProvider)
        .getRoom(widget.roomId)
        .then((value) => maxNum = value.maxNum);
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
    final members = ref.watch(membersStreamProvider(widget.roomId));
    return members.when(
      data: (data) {
        if (data.length == maxNum){
          isLoading = true;
          setState(() {});
        }
        if (!data.map((e) => e.assignedId).toList().contains(0) &&
            data.length == maxNum) {
          Future.delayed(const Duration(seconds: 3));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/chat/${widget.roomId}/1');
          });
        }
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: ColorConstant.back,
            body: widget.roomId.length > 10
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('オンライン', style: TextStyleConstant.bold18),
                      const SizedBox(height: 40),
                      Text(isLoading ? '役職割り当て中...' : 'マッチング中...',
                          style: TextStyleConstant.normal28),
                      const SizedBox(height: 48),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '${data.length - 1}',
                                style: TextStyleConstant.bold32),
                            const WidgetSpan(child: SizedBox(width: 8)),
                            const TextSpan(
                                text: '/', style: TextStyleConstant.normal32),
                            const WidgetSpan(child: SizedBox(width: 8)),
                            const TextSpan(
                                text: '4', style: TextStyleConstant.normal24),
                            const WidgetSpan(child: SizedBox(width: 4)),
                            const TextSpan(
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
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('ROOM ID', style: TextStyleConstant.normal24),
                      const SizedBox(height: 8),
                      Text(widget.roomId, style: TextStyleConstant.bold48),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              const flavor = String.fromEnvironment('flavor');
                              if (flavor == 'prod') {
                                Share.share(
                                    'https://ai-werewolf.web.app/#/wait/${widget.roomId}/0');
                              } else {
                                Share.share(
                                    'https://ai-werewolf-dev.web.app/#/wait/${widget.roomId}/0');
                              }
                            },
                            child: const Icon(Icons.share,
                                color: ColorConstant.main),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.roomId));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('テキストがクリップボードに保存されました'),
                                ),
                              );
                            },
                            child: const Icon(Icons.copy,
                                color: ColorConstant.main),
                          ),
                        ],
                      ),
                      const SizedBox(height: 56),
                      Text(isLoading ? '役職割り当て中...' : 'マッチング中...',
                          style: TextStyleConstant.normal18),
                      const SizedBox(height: 24),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '${data.length - 1}',
                                style: TextStyleConstant.bold32),
                            const WidgetSpan(child: SizedBox(width: 8)),
                            const TextSpan(
                                text: '/', style: TextStyleConstant.normal28),
                            const WidgetSpan(child: SizedBox(width: 8)),
                            const TextSpan(
                                text: '4', style: TextStyleConstant.normal18),
                            const WidgetSpan(child: SizedBox(width: 4)),
                            const TextSpan(
                                text: '人', style: TextStyleConstant.normal14),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
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
