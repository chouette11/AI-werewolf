import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class MakeRoomPage extends ConsumerStatefulWidget {
  const MakeRoomPage({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

  @override
  ConsumerState<MakeRoomPage> createState() => _MakeRoomPageState();
}

class _MakeRoomPageState extends ConsumerState<MakeRoomPage> {
  int maxNum = 404;

  @override
  void initState() {
    Future(() async {
      if (kIsWeb) {
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
        return Scaffold(
          backgroundColor: ColorConstant.back,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('ROOM ID', style: TextStyleConstant.normal24),
              const SizedBox(height: 8),
              Text(widget.roomId, style: TextStyleConstant.bold48),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, color: ColorConstant.main),
                  SizedBox(width: 20),
                  Icon(Icons.copy, color: ColorConstant.main),
                ],
              ),
              const SizedBox(height: 48),
              const Text('メンバー待機中...', style: TextStyleConstant.normal18),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline,
                      color: ColorConstant.main, size: 40),
                  SizedBox(width: 32),
                  Image(image: AssetImage('assets/images/polygon1.png')),
                  SizedBox(width: 16),
                  Image(image: AssetImage('assets/images/polygon2.png')),
                  SizedBox(width: 16),
                  Image(image: AssetImage('assets/images/polygon3.png')),
                  SizedBox(width: 32),
                  Icon(Icons.group_outlined,
                      color: ColorConstant.main, size: 40),
                ],
              )
            ],
          ),
        );
      },
      error: (_, __) => Text(_.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
