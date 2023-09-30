import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_werewolf/page/result/result_page.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/repository/member_repository.dart';
import 'package:ai_werewolf/repository/message_repository.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/enum/role.dart';

class NightPage extends ConsumerWidget {
  const NightPage({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));
    final kill = ref.watch(randomKillProvider(roomId));
    final room = ref.watch(roomStreamProvider(roomId));
    return Scaffold(
      backgroundColor: ColorConstant.back,
      body: Center(
        child: members.when(
          data: (mem) {
            final livingMem =
                ref.read(memberRepositoryProvider).getLivingMembers(mem);
            // 処刑で試合が決まるかどうか
            if (livingMem.indexWhere((e) => e.uid == 'gpt') == -1) {
              return ResultPage(roomId: roomId, winner: RoleEnum.human.displayName);
            } else if (livingMem.length <= 2) {
              return ResultPage(roomId: roomId, winner: RoleEnum.humanoid.displayName);
            } else {
              return ResultPage(roomId: roomId, winner: RoleEnum.humanoid.displayName);
              return kill.when(
                data: (data) {
                  // 惨殺で試合が決まるかどうか
                  if (data == 404) {
                    return const Text('AIが惨殺しています');
                  } else if (data == 100) {
                    return const Text('村人');
                  } else if (data == 200) {
                    return const Text('AI');
                  } else {
                    // 試合継続
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(builder: (context) {
                          return room.when(
                            data: (data) {
                              return Text('プレイヤー${data.killedId}が惨殺されました');
                            },
                            error: (_, __) => Text(_.toString()),
                            loading: () => const SizedBox.shrink(),
                          );
                        }),
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
                            context.go('/chat/$roomId/0');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  }
                },
                error: (_, __) => const Text('error'),
                loading: () => const CircularProgressIndicator(),
              );
            }
          },
          error: (_, __) => const Text('error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
