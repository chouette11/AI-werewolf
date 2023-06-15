import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
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
    final messages = ref.watch(messagesStreamProvider(widget.roomId));
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final uid = ref.watch(uidProvider);
    return AlertDialog(
      backgroundColor: ColorConstant.base,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: SizedBox(
        height: 360,
        width: 240,
        child: Center(
          child: messages.when(
            data: (data) {
              if (data.length == widget.maxNum) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(limitTimeProvider.notifier).startTimer();
                });
                context.pop();
              }
              return members.when(
                data: (members) {
                  if (members[uid] == null) {
                    return const Text(
                      '配役決め中です...',
                      style: TextStyleConstant.normal16,
                    );
                  }
                  return Column(
                    children: [
                      const Text('あなたは', style: TextStyleConstant.normal16),
                      const SizedBox(height: 8),
                      Text(
                        'プレイヤー${members[uid]}(一般人)',
                        style: TextStyleConstant.bold24,
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          Spacer(),
                          Text('お題', style: TextStyleConstant.normal18),
                          Spacer(),
                          Text('うどん', style: TextStyleConstant.bold28),
                          Spacer(),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: TextField(
                          onChanged: (value) => ref
                              .read(startTextFieldProvider.notifier)
                              .update((state) => value),
                          cursorColor: ColorConstant.main,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstant.main,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstant.main,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: '解答を入力してください',
                            hintStyle: TextStyleConstant.normal16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Visibility(
                        visible: data.length != widget.maxNum && isSend,
                        child: const Text(
                          '全員が送信するまでしばらくお待ち下さい...',
                          style: TextStyleConstant.normal12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 48,
                        width: 80,
                        child: ElevatedButton(
                          onPressed: isSend
                              ? null
                              : () {
                                  final value =
                                      ref.read(startTextFieldProvider);
                                  ref
                                      .read(messageRepositoryProvider)
                                      .addMessage(value, widget.roomId);
                                  isSend = true;
                                  setState(() {});
                                }, //textfieldに入力された値を送信する
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.main,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
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
              );
            },
            error: (_, __) => const Text('error'),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
