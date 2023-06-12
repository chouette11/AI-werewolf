import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';

class BottomTextField extends ConsumerWidget {
  const BottomTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 96,
      color: ColorConstant.secondary,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Text('あなたはユーザー１（一般人）'),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 320,
                  child: TextFormField(
                    onChanged: (value) => ref
                        .watch(exampleTextFieldProvider.notifier)
                        .update((state) => value),
                    textAlign: TextAlign.left,
                    autofocus: true,
                    cursorColor: ColorConstant.accent,
                    decoration: const InputDecoration(
                      fillColor: ColorConstant.base,
                      filled: true,
                      hintText: '解答を入力',
                      hintStyle:
                          TextStyle(fontSize: 16, color: ColorConstant.accent),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: ColorConstant.accent,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    final content = ref.read(exampleTextFieldProvider);
                    ref.read(messageRepositoryProvider).addMessage(content, "0000");
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
