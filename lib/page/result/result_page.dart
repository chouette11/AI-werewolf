import 'dart:math';

import 'package:ai_werewolf/page/result/component/result_users.dart';
import 'package:ai_werewolf/page/result/component/back_title_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/member_repository.dart';
import 'package:ai_werewolf/repository/message_repository.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/enum/role.dart';
import 'package:confetti/confetti.dart';

class ResultPage extends ConsumerStatefulWidget {
  const ResultPage({
    Key? key,
    required this.roomId,
    required this.winner,
  }) : super(key: key);
  final String roomId;
  final String winner;

  @override
  ConsumerState<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends ConsumerState<ResultPage> {
  late ConfettiController controller;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final uid = ref.watch(uidProvider);
    return Scaffold(
      backgroundColor: ColorConstant.back,
      body: Center(
        child: members.when(
          data: (members) {
            final member = members[members.indexWhere((e) => e.uid == uid)];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  member.role,
                  style: TextStyleConstant.normal32,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.winner == member.role ? '勝利' : '敗北',
                  style: TextStyleConstant.bold60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ConfettiWidget(
                        confettiController: controller,
                        blastDirection: 0, // radial value - RIGHT
                        emissionFrequency: 0.1,
                        numberOfParticles: 10,
                        gravity: 0,
                        colors: [Colors.white, Color(0xff74AA9C)],
                        blastDirectionality: BlastDirectionality
                            .explosive, // don't specify a direction, blast randomly
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            controller.play();
                          },
                          child: const Text('singles')),
                    ),
                    Icon(
                      member.role == RoleEnum.human.displayName
                          ? Icons.diversity_3
                          : Icons.psychology_outlined,
                      color: member.role == RoleEnum.human.displayName
                          ? ColorConstant.main
                          : ColorConstant.accent,
                      size: 152,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ResultUsers(roomId: widget.roomId),
                const SizedBox(height: 48),
                BackTitleButton(
                  onTap: () async {
                    await ref
                        .read(messageRepositoryProvider)
                        .deleteAllMessage(widget.roomId);
                    await ref
                        .read(memberRepositoryProvider)
                        .resetVoted(widget.roomId);
                    await ref
                        .read(roomRepositoryProvider)
                        .resetKilledId(widget.roomId);
                    ref.read(limitTimeProvider.notifier).reset();
                    ref.refresh(answerAssignedIdProvider);
                    context.go('/');
                  },
                ),
              ],
            );
          },
          error: (_, __) => const Text('error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
