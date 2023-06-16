import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/entity/member/member_entity.dart';
import 'package:wordwolf/page/chat/component/end_dialog.dart';
import 'package:wordwolf/page/chat/component/night_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class ExecutedDialog extends ConsumerWidget {
  const ExecutedDialog({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));
    final room = ref.watch(roomStreamProvider(roomId));

    return members.when(
      data: (data) {
        MemberEntity decidedExecuteId() {
          // 怪しいかも
          data.sort((a, b) => -a.voted.compareTo(b.voted));
          return data[0];
        }

        String  isContenue() {
          if (data[data.indexWhere((e) => e.userId == 'gpt')].isLive == false) {
            return '村人';
          }
          if (data.length <= 2) {
            return 'AI';
          }
          return '続く';
        }

        return room.when(
          data: (room) {
            // プレイヤーxのxでソート
            data.sort((a, b) => a.assignedId.compareTo(b.assignedId));
            return AlertDialog(
              backgroundColor: ColorConstant.black100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              content: SizedBox(
                width: 240,
                height: 400,
                child: Column(
                  children: [
                    Text('プレイヤー${decidedExecuteId().assignedId}が処刑されました。'),
                    ElevatedButton(
                      onPressed: () async {
                        final member = decidedExecuteId();
                        await ref
                            .read(roomRepositoryProvider)
                            .killMember(roomId, member.userId);
                        if (isContenue() == '続く') {
                          context.pop();
                          showDialog(
                            context: context,
                            builder: (context) => NightDialog(roomId: roomId),
                          );
                        } else if(isContenue() == '村人') {
                          context.pop();
                          showDialog(
                            context: context,
                            builder: (context) => EndDialog(result: '村人'),
                          );
                        } else {
                          context.pop();
                          showDialog(
                            context: context,
                            builder: (context) => EndDialog(result: 'AI'),
                          );
                        }
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return const Text('エラーが発生しました');
          },
          loading: () => const CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return const Text('エラーが発生しました');
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
