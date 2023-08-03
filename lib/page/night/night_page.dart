import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/member_repository.dart';
import 'package:wordwolf/repository/message_repository.dart';
import 'package:wordwolf/repository/room_repository.dart';

class NightPage extends ConsumerWidget {
  const NightPage({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));
    final kill = ref.watch(randomKillProvider(roomId));
    final room = ref.watch(roomStreamProvider(roomId));
    return Scaffold(
      body: Center(
        child: members.when(
          data: (mem) {
            final livingMem =
                ref.read(memberRepositoryProvider).getLivingMembers(mem);
            if (livingMem.indexWhere((e) => e.userId == 'gpt') == -1) {
              return const Text('村人');
            } else if (livingMem.length <= 2) {
              return const Text('AI');
            } else {
              return kill.when(
                data: (data) {
                  if (data == 404) {
                    return const Text('AIが惨殺しています');
                  } else if (data == 100) {
                    return const Text('村人');
                  } else if (data == 200) {
                    return const Text('AI');
                  } else {
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
                            context.push('/chat/${false}', extra: roomId);
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
