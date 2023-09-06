import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';
import 'package:wordwolf/repository/room_repository.dart';

class BottomTextField extends ConsumerWidget {
  const BottomTextField({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(memberStreamProvider(roomId));

    return member.when(
      data: (data) {
        if (!data.isLive) {
          return DiedBottomSheet(role: data.role);
        }
        return Container(
          height: 64,
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
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: ref.read(messageTextFieldController),
                      textAlign: TextAlign.left,
                      autofocus: true,
                      cursorColor: ColorConstant.black30,
                      decoration: const InputDecoration(
                        fillColor: ColorConstant.black90,
                        filled: true,
                        hintText: 'メッセージを入力',
                        hintStyle: TextStyle(
                            fontSize: 16, color: ColorConstant.black50),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: ColorConstant.black30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final content =
                            ref.read(messageTextFieldController).text;

                        // 空文字の場合
                        if (content.isEmpty) {
                          return;
                        }

                        final room = await ref
                            .read(roomRepositoryProvider)
                            .getRoom(roomId);
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
          ),
        );
      },
      error: (_, __) => Text(_.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class DiedBottomSheet extends StatelessWidget {
  const DiedBottomSheet({Key? key, required this.role}) : super(key: key);
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
