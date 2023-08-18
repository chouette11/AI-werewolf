import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class StartDialog extends ConsumerWidget {
  const StartDialog({super.key, required this.roomId});
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(maxMemberProvider);
    return AlertDialog(
      backgroundColor: ColorConstant.back,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      content: SizedBox(
        width: 240,
        height: 160,
        child: Column(
          children: [
            const Text(
              'ID',
              style: TextStyleConstant.normal24,
            ),
            const SizedBox(height: 8),
            Text(
              roomId,
              style: TextStyleConstant.normal32,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('参加人数：', style: TextStyleConstant.normal16),
                SizedBox(
                  height: 70,
                  child: NumberPicker(
                    textStyle: TextStyleConstant.normal12,
                    selectedTextStyle: TextStyleConstant.normal16,
                    itemHeight: 24,
                    itemWidth: 48,
                    maxValue: 5,
                    minValue: 2,
                    step: 1,
                    onChanged: (int value) => ref
                        .read(maxMemberProvider.notifier)
                        .update((state) => value),
                    value: value,
                  ),
                ),
                const Text('人', style: TextStyleConstant.normal16),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 32,
                width: 80,
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
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "コピー",
                        style: TextStyleConstant.normal12.copyWith(
                          color: ColorConstant.main,
                        ),
                      ),
                      const Icon(
                        Icons.content_copy,
                        color: ColorConstant.main,
                        size: 12,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 32,
                width: 80,
                child: ElevatedButton(
                  onPressed: () {
                    Share.share(roomId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.accent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "共有",
                        style: TextStyleConstant.normal12.copyWith(
                          color: ColorConstant.main,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.share,
                        color: ColorConstant.main,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: SizedBox(
            height: 48,
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                final uuid = const Uuid().v4();
                ref.read(uidProvider.notifier).update((state) => uuid);
                await ref.read(roomRepositoryProvider).makeRoom(roomId, value);
                await ref.read(roomRepositoryProvider).joinRoom(roomId);
                ref.read(isMakeRoomProvider.notifier).update((state) => true);
                context.go("/make/$roomId");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.accent,
              ),
              child: const Text("入室する", style: TextStyleConstant.normal16),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
