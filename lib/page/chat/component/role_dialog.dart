import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

class RoleDialog extends ConsumerStatefulWidget {
  const RoleDialog(this.roomId, this.maxNum, {super.key});

  final String roomId;
  final int maxNum;

  @override
  ConsumerState<RoleDialog> createState() => _RoleDialogState();
}

class _RoleDialogState extends ConsumerState<RoleDialog> {
  bool isSend = false;
  int count = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(mounted) {
        setState(() => count++);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (count >= 5) {
      ref.read(limitTimeProvider.notifier).startTimer();
      context.pop();
    }
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final uid = ref.watch(uidProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: ColorConstant.black100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        content: SizedBox(
          height: 240,
          width: 240,
          child: Center(
            child: members.when(
              data: (members) {
                final member =
                    members[members.indexWhere((e) => e.userId == uid)];
                if (member.assignedId == '0') {
                  return const Text(
                    '配役決め中です...',
                    style: TextStyleConstant.normal16,
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('あなたは', style: TextStyleConstant.normal16),
                    const SizedBox(height: 8),
                    Text(
                      'プレイヤー${member.assignedId}(一般人)',
                      style: TextStyleConstant.bold24,
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 48,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: isSend
                            ? null
                            : () {
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
                          '把握した',
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
        ),
      ),
    );
  }
}
