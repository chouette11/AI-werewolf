import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/member_repository.dart';

class NightPage extends ConsumerWidget {
  const NightPage({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));
    final kill = ref.watch(randomKillProvider(roomId));
    return Scaffold(
      body: Center(
        child: members.when(
          data: (mem) {
            final livingMem = ref.read(memberRepositoryProvider).getLivingMembers(mem);
            if (livingMem[livingMem.indexWhere((e) => e.userId == 'gpt')].isLive ==
                false) {
              return const Text('村人');
            } else if (livingMem.length <= 2) {
              return const Text('AI');
            } else {
              return kill.when(
                data: (data) {
                  if (data == 0) {
                    return const Text('村人');
                  } else if (data == 1) {
                    return const Text('AI');
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('xが惨殺されました'),
                        ElevatedButton(onPressed: () {
                          context.push('/chat/${false}', extra: roomId);
                        }, child: Text('OK'))
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
