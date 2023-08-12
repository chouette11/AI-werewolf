import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
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
    final members = ref.watch(membersStreamProvider(roomId));
    final uid = ref.watch(uidProvider);
    final member = ref.watch(memberStreamProvider(roomId));

    return member.when(
      data: (data) {
        if (!data.isLive) {
          return DiedBottomSheet(role: data.role);
        }
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
                    final member =
                        data[data.indexWhere((e) => e.userId == uid)];
                    return Text(
                      'あなたはユーザー${member.assignedId}（${member.role}）',
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
                        controller: ref.read(messageTextFieldController),
                        textAlign: TextAlign.left,
                        autofocus: true,
                        cursorColor: ColorConstant.main,
                        decoration: const InputDecoration(
                          fillColor: ColorConstant.black90,
                          filled: true,
                          hintText: '解答を入力',
                          hintStyle: TextStyle(
                              fontSize: 16, color: ColorConstant.black50),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorConstant.text,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () async {
                        final content =
                            ref.read(messageTextFieldController).text;
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
