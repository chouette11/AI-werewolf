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
      backgroundColor: ColorConstant.black100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        width: 240,
        height: 200,
        child: Column(
          children: [
            const Text(
              'ID',
              style: TextStyleConstant.normal32,
            ),
            const SizedBox(height: 16),
            Text(
              roomId,
              style: TextStyleConstant.normal32,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                const Spacer(),
                Text('参加人数：', style: TextStyleConstant.normal16),
                SizedBox(
                  height: 72,
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
                Text('人', style: TextStyleConstant.normal16),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: Row(
            children: [
              const Spacer(),
              SizedBox(
                height: 48,
                width: 120,
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
                    backgroundColor: ColorConstant.main,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "コピー",
                    style: TextStyleConstant.normal16.copyWith(
                      color: ColorConstant.black100,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 48,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    Share.share(roomId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.main,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "共有",
                    style: TextStyleConstant.normal16.copyWith(
                      color: ColorConstant.black100,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: SizedBox(
            height: 48,
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                final uuid = const Uuid().v4();
                ref.read(uidProvider.notifier).update((state) => uuid);
                ref.read(roomRepositoryProvider).makeRoom(roomId, value);
                ref.read(roomRepositoryProvider).joinRoom(roomId);
                context.push("/chat", extra: roomId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "参加する",
                style: TextStyleConstant.normal16.copyWith(
                  color: ColorConstant.black0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
