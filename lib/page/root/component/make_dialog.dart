import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/room_repository.dart';

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
          child: SizedBox(
            height: 48,
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                await ref.read(roomRepositoryProvider).makeRoom(roomId, value);
                await ref.read(roomRepositoryProvider).joinRoom(roomId);
                ref.read(isMakeRoomProvider.notifier).update((state) => true);
                context.go("/wait/$roomId/1");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.accent,
              ),
              child: const Text("作成する", style: TextStyleConstant.normal16),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
