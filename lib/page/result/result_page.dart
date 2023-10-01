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

class ResultPage extends ConsumerWidget {
  const ResultPage({
    Key? key,
    required this.roomId,
    required this.winner,
  }) : super(key: key);
  final String roomId;
  final String winner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));
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
                  winner == member.role ? '勝利' : '敗北',
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
                ResultUsers(roomId: roomId),
                const SizedBox(height: 48),
                BackTitleButton(
                  onTap: () async {
                    await ref
                        .read(messageRepositoryProvider)
                        .deleteAllMessage(roomId);
                    await ref.read(memberRepositoryProvider).resetVoted(roomId);
                    await ref
                        .read(roomRepositoryProvider)
                        .resetKilledId(roomId);
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
