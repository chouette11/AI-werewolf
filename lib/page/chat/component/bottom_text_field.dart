import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

class BottomTextField extends ConsumerWidget {
  const BottomTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 64,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.black95,
                    borderRadius: BorderRadius.circular(32)),
                child: TextFormField(
                  onChanged: (value) => ref
                      .watch(exampleTextFieldProvider.notifier)
                      .update((state) => value),
                  textAlign: TextAlign.left,
                  autofocus: true,
                  cursorColor: ColorConstant.purple40,
                  decoration: const InputDecoration(
                    fillColor: ColorConstant.purple40,
                    filled: true,
                    hintText: 'メッセージを入力',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                
              },
              child: const Icon(
                Icons.send,
                color: ColorConstant.purple40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
