import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    return AlertDialog(
      backgroundColor: ColorConstant.black100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        width: 240,
        height: 160,
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
            const SizedBox(height: 56),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
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
                  color: ColorConstant.base,
                ),
              ),
            ),
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
                ref.read(roomRepositoryProvider).makeRoom(roomId, 5);
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
