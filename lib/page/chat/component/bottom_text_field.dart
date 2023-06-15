import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';

class BottomTextField extends ConsumerWidget {
  const BottomTextField({
    super.key,
    required this.roomId,
  });
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));
    final uid = ref.watch(uidProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      height: 96,
      color: ColorConstant.secondary,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            members.when(
              data: (data) {
                if (data[uid] == null) {
                  return const Text(
                    'loading',
                    style: TextStyleConstant.normal12,
                  );
                }
                return Text(
                  'あなたはユーザー${data[uid]}（一般人）',
                  style: TextStyleConstant.bold12,
                );
              },
              error: (_, __) => const Text('error'),
              loading: () => const Text(
                'loading',
                style: TextStyleConstant.normal12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 320,
                  child: TextFormField(
                    onChanged: (value) => ref
                        .watch(messageTextFieldProvider.notifier)
                        .update((state) => value),
                    textAlign: TextAlign.left,
                    autofocus: true,
                    cursorColor: ColorConstant.main,
                    decoration: const InputDecoration(
                      fillColor: ColorConstant.black100,
                      filled: true,
                      hintText: '解答を入力',
                      hintStyle:
                          TextStyle(fontSize: 16, color: ColorConstant.main),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: ColorConstant.black0,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    final content = ref.read(messageTextFieldProvider);
                    ref
                        .read(messageRepositoryProvider)
                        .addMessage(content, roomId);
                  },
                  child: const Icon(
                    Icons.send,
                    color: ColorConstant.main,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
