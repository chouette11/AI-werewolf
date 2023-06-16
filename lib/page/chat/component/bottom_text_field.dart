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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: ColorConstant.black100,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90,
            offset: Offset(0, -0.25),
            blurRadius: 0.5,
          ),
        ],
      ),
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
                const Spacer(),
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
                      fillColor: ColorConstant.black90,
                      filled: true,
                      hintText: '解答を入力',
                      hintStyle:
                          TextStyle(fontSize: 16, color: ColorConstant.black50),
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
                    ref.read(messageTextFieldProvider.notifier).update((_) => '');
                  },
                  child: const Icon(
                    Icons.send,
                    color: ColorConstant.main,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
