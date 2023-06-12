import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

class JoinDialog extends ConsumerWidget {
  const JoinDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: ColorConstant.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        width: 240,
        height: 160,
        child: Column(
          children: [
            const Text(
              '参加ID',
              style: TextStyleConstant.normal32,
            ),
            const SizedBox(height: 56),
            SizedBox(
              height: 40,
              width: 224,
              child: TextField(
                onChanged: (value) => ref
                    .watch(idTextFieldProvider.notifier)
                    .update((state) => value),
                textAlign: TextAlign.left,
                autofocus: true,
                cursorColor: ColorConstant.accent,
                decoration: const InputDecoration(
                  fillColor: ColorConstant.base,
                  filled: true,
                  hintText: 'IDを入力',
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
                final textValue = ref.watch(idTextFieldProvider);
                context.push("/chat", extra: textValue);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "参加する",
                style: TextStyleConstant.normal16.copyWith(
                  color: ColorConstant.base,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
