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
    controller.play();
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final uid = ref.watch(uidProvider);
    return Scaffold(
      backgroundColor: ColorConstant.back,
      body: Center(
        child: members.when(
          data: (members) {
            final member = members[members.indexWhere((e) => e.uid == uid)];
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Visibility(
                  visible: widget.winner == member.role,
                  child: ConfettiWidget(
                    confettiController: controller,
                    blastDirection: 0,
                    emissionFrequency: 0.1,
                    numberOfParticles: 10,
                    gravity: 1,
                    colors: const [ColorConstant.black100, ColorConstant.accent],
                    blastDirectionality: BlastDirectionality.explosive,
                    minBlastForce: 10,
                    shouldLoop: true,
                  ),
                ),
                Column(
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
                    Icon(
                      member.role == RoleEnum.human.displayName
                          ? Icons.diversity_3
                          : Icons.psychology_outlined,
                      color: member.role == RoleEnum.human.displayName
                          ? ColorConstant.main
                          : ColorConstant.accent,
                      size: 152,
                    ),
                    const SizedBox(height: 8),
                    ResultUsers(roomId: widget.roomId),
                    const SizedBox(height: 48),
                    ArrowButton(
                      title: 'タイトルに戻る',
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
