import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/util/enum/role.dart';

class RoleDialog extends ConsumerStatefulWidget {
  const RoleDialog(this.roomId, this.isPop, {super.key});

  final String roomId;
  final bool isPop;

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
      if (mounted) {
        setState(() => count++);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 5秒経過したときこのダイアログを消す
    if (count >= 5) {
      ref.read(limitTimeProvider.notifier).startTimer();
      context.pop();
    }
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final uid = ref.watch(uidProvider);
    return WillPopScope(
      onWillPop: () async => widget.isPop,
      child: AlertDialog(
        backgroundColor: ColorConstant.back,
        content: SizedBox(
          height: 200,
          width: 120,
          child: Center(
            child: members.when(
              data: (members) {
                final member =
                    members[members.indexWhere((e) => e.userId == uid)];
                if (member.assignedId == 0) {
                  return const Text(
                    '配役決め中です...',
                    style: TextStyleConstant.normal16,
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('あなたは', style: TextStyleConstant.normal16),
                    Icon(
                      member.role == RoleEnum.human.displayName
                          ? Icons.diversity_3
                          : Icons.psychology_outlined,
                      color: member.role == RoleEnum.human.displayName
                          ? ColorConstant.main
                          : ColorConstant.accent,
                      size: 120,
                    ),
                    Text(member.role, style: TextStyleConstant.bold24),
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
