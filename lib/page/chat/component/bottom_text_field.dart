import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/page/chat/component/answer_dialog.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';
import 'package:wordwolf/repository/room_repository.dart';

const textFieldkey = GlobalObjectKey('text');

class CustomBottomSheet extends ConsumerWidget {
  const CustomBottomSheet({
    super.key,
    required this.roomId,
    required this.counter,
  });

  final String roomId;
  final int counter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(memberStreamProvider(roomId));

    return member.when(
      data: (data) {
        // 残り時間がない場合
        if (counter <= 0) {
          return _EndBottomSheet(roomId: roomId, role: data.role);
        }
        // 死んでいる場合
        if (!data.isLive) {
          return _DiedBottomSheet(role: data.role);
        }
        return _BottomTextField(roomId: roomId);
      },
      error: (_, __) => Text(_.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class _BottomTextField extends ConsumerWidget {
  const _BottomTextField({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(messageTextFieldController).text;
    final textSpan = TextSpan(
      text: text, // Widthを知りたい文字
      style: TextStyleConstant.normal16
          .copyWith(color: ColorConstant.black30), // Widthを計測する種のスタイル
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr, //　右始まりか左始まりか
    )..layout(); // layoutでビルドして、サイズなを取得できるようになる。
    final _localTextWidth = textPainter.size.width + 32;

    double _checkWidth() {
      final box = textFieldkey.currentContext;
      if (box != null) {
        final data = box.findRenderObject();
        // これでrendaring情報を取得できます。
        if (data is RenderBox) {
          // abstractくらすなのでisでクラスを指定
          return data.size.width; //これでWidthを取得
        }
      }
      return 1;
    }

    int maxLine = (_localTextWidth ~/ _checkWidth()) + 1;
    if (maxLine != 1) {
      maxLine = ((_localTextWidth + maxLine * 32) ~/ _checkWidth()) + 1;
    }

    return Container(
      height: 64 + (28.0 * (maxLine - 1)),
      decoration: const BoxDecoration(
        color: ColorConstant.back,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black10,
            offset: Offset(0, -0.25),
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              key: textFieldkey,
              child: CustomTextBox(maxLine),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  final content = ref.read(messageTextFieldController).text;

                  // 空文字の場合
                  if (content.isEmpty) {
                    return;
                  }

                  final room =
                      await ref.read(roomRepositoryProvider).getRoom(roomId);
                  ref
                      .read(messageRepositoryProvider)
                      .addMessage(content, roomId, room.topic);
                  ref.read(messageTextFieldController).clear();
                },
                child: const Icon(
                  Icons.send,
                  color: ColorConstant.accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiedBottomSheet extends StatelessWidget {
  const _DiedBottomSheet({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: ColorConstant.accent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Spacer(),
            Text(
              'あなたは死にました（$role）',
              style: TextStyleConstant.bold12,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _EndBottomSheet extends StatelessWidget {
  const _EndBottomSheet({super.key, required this.roomId, required this.role});

  final String roomId;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: ColorConstant.accent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Spacer(),
            Text(
              'あなたは $role',
              style: TextStyleConstant.bold12,
            ),
            const Spacer(),
            SizedBox(
              width: 80,
              height: 32,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AnswerDialog(roomId: roomId);
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorConstant.accent,
                  backgroundColor: ColorConstant.main,
                ),
                child: Text(
                  '解答',
                  style: TextStyleConstant.bold12.copyWith(
                    color: ColorConstant.accent,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class CustomTextBox extends ConsumerWidget {
  const CustomTextBox(this.maxLine, {Key? key}) : super(key: key);
  final int maxLine;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return TextFormField(
        controller: ref.read(messageTextFieldController),
        textAlign: TextAlign.left,
        autofocus: true,
        cursorColor: ColorConstant.black30,
        maxLines: maxLine,
        decoration: const InputDecoration(
          fillColor: ColorConstant.black90,
          filled: true,
          hintText: 'メッセージを入力',
          hintStyle: TextStyle(fontSize: 16, color: ColorConstant.black50),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide.none,
          ),
        ),
        style:
            TextStyleConstant.normal16.copyWith(color: ColorConstant.black30));
  }
}
