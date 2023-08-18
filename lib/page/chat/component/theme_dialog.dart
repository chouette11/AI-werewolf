import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/page/chat/component/role_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';

class ThemeDialog extends ConsumerStatefulWidget {
  const ThemeDialog(this.roomId, this.maxNum, {super.key});

  final String roomId;
  final int maxNum;

  @override
  ConsumerState<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends ConsumerState<ThemeDialog> {
  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    final topic = ref.watch(topicProvider(widget.roomId));
    final messages = ref.watch(messagesStreamProvider(widget.roomId));

    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: ColorConstant.back,
        content: topic.when(
          data: (topic) {
            return SizedBox(
              height: 280,
              width: 240,
              child: Center(
                child: messages.when(
                  data: (data) {
                    const flavor = String.fromEnvironment('flavor');
                    if (flavor == 'tes') {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.pop();
                        showDialog(
                          context: context,
                          builder: (context) => RoleDialog(widget.roomId),
                        );
                      });
                    }

                    if (data.length == widget.maxNum) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.pop();
                        showDialog(
                          context: context,
                          builder: (context) => RoleDialog(widget.roomId),
                        );
                      });
                    }
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Spacer(),
                            const Text('お題', style: TextStyleConstant.normal18),
                            const Spacer(),
                            Text(topic, style: TextStyleConstant.bold28),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: TextField(
                            onChanged: (value) => ref
                                .read(startTextFieldProvider.notifier)
                                .update((state) => value),
                            cursorColor: ColorConstant.black50,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 2,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: ColorConstant.black90,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorConstant.main,
                                ),
                              ),
                              hintText: '解答を入力してください',
                              hintStyle: TextStyleConstant.normal16
                                  .copyWith(color: ColorConstant.black50),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Visibility(
                          visible: data.length != widget.maxNum && isSend,
                          child: const Text(
                            '全員が送信するまでしばらくお待ち下さい...',
                            style: TextStyleConstant.normal12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 40,
                          width: 80,
                          child: ElevatedButton(
                            onPressed: isSend
                                ? null
                                : () {
                                    final value =
                                        ref.read(startTextFieldProvider);
                                    ref
                                        .read(messageRepositoryProvider)
                                        .addMessage(
                                            value, widget.roomId, topic);
                                    isSend = true;
                                    setState(() {});
                                    // ルーム作成者の場合、gptにリクエストを送る
                                    final isMakeRoom =
                                        ref.read(isMakeRoomProvider);
                                    if (isMakeRoom) {
                                      ref
                                          .read(messageRepositoryProvider)
                                          .addMessageFromGptToTopic(
                                              topic, widget.roomId);
                                    }
                                  }, //textfieldに入力された値を送信する
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.accent,
                            ),
                            child: Text(
                              '送信',
                              style: TextStyleConstant.bold14
                                  .copyWith(color: ColorConstant.black100),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  error: (_, __) => const Text('error'),
                  loading: () => const CircularProgressIndicator(),
                ),
              ),
            );
          },
          error: (_, __) => const Text('error'),
          loading: () => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
