import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/constant/const.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/util/enum/role.dart';

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
  DateTime startTime = DateTime.now();

  @override
  void initState() {
    Future(() async {
      final room = await ref.read(roomRepositoryProvider).getRoom(widget.roomId);
      startTime = room.startTime;
    });
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
    if (count >= ROLE_DIALOG_TIME) {
      ref.read(limitTimeProvider.notifier).startTimer(startTime);
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
