import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/page/start/component/polygon.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class MakeRoomPage extends ConsumerStatefulWidget {
  const MakeRoomPage({
    Key? key,
    required this.roomId,
    required this.isJoin,
  }) : super(key: key);
  final String roomId;
  final bool isJoin;

  @override
  ConsumerState<MakeRoomPage> createState() => _MakeRoomPageState();
}

class _MakeRoomPageState extends ConsumerState<MakeRoomPage> {
  int maxNum = 404;
  int count = 100;

  @override
  void initState() {
    Future(() async {
      if (kIsWeb && !widget.isJoin) {
        final uuid = const Uuid().v4();
        ref.read(uidProvider.notifier).update((state) => uuid);
        await ref.read(roomRepositoryProvider).joinRoom(widget.roomId);
      }
    });
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
        if (data.length == maxNum) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/chat/${widget.roomId}/1');
          });
        }
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: ColorConstant.back,
            body: Column(
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
                        Share.share(
                            'https://wordwolf-main.web.app/#/make/${widget.roomId}/0');
                      },
                      child: const Icon(Icons.share, color: ColorConstant.main),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.roomId));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('テキストがクリップボードに保存されました'),
                          ),
                        );
                      },
                      child: const Icon(Icons.copy, color: ColorConstant.main),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                const Text('メンバー待機中...', style: TextStyleConstant.normal18),
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
