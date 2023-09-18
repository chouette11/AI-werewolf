import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/member_repository.dart';
import 'package:wordwolf/repository/message_repository.dart';
import 'package:wordwolf/repository/room_repository.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';

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
            final member =
                members[members.indexWhere((e) => e.userId == uid)];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  member.role,
                  style: TextStyleConstant.bold32,
                ),
                Text(
                  winner == member.role ? '勝利' : '敗北',
                  style: TextStyleConstant.bold48,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(messageRepositoryProvider)
                        .deleteAllMessage(roomId);
                    await ref
                        .read(memberRepositoryProvider)
                        .resetVoted(roomId);
                    await ref
                        .read(roomRepositoryProvider)
                        .resetKilledId(roomId);
                    ref.read(limitTimeProvider.notifier).reset();
                    ref.refresh(answerAssignedIdProvider);
                    context.go('/');
                  },
                  child: const Text('タイトルに戻る'),
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
