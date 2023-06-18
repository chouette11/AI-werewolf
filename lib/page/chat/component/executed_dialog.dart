import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/entity/member/member_entity.dart';
import 'package:wordwolf/page/chat/component/end_dialog.dart';
import 'package:wordwolf/page/chat/component/night_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';
import 'package:wordwolf/repository/room_repository.dart';

class ExecutedDialog extends ConsumerWidget {
  const ExecutedDialog({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));

    return members.when(
      data: (data) {
        MemberEntity decidedExecuteId() {
          data.sort((a, b) => -a.voted.compareTo(b.voted));
          return data[0];
        }

        void isContenue(int maxNum) {
          if (data[data.indexWhere((e) => e.userId == 'gpt')].isLive == false) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) => const EndDialog(result: '村人'),
            );
          } else if (data.length <= 2) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) => const EndDialog(result: 'AI'),
            );
          } else {
            ref.read(messageRepositoryProvider).deleteAllMessage(roomId);
            final uid = ref.read(uidProvider);
            if (data[data.indexWhere((e) => e.userId != 'gpt')].userId == uid) {
              ref.read(roomRepositoryProvider).randomKill(roomId, data);
            }
            ref.read(limitTimeProvider.notifier).reset();
            context.pop();
            showDialog(
              context: context,
              builder: (context) => NightDialog(roomId: roomId),
            );
          }
        }

        return AlertDialog(
          backgroundColor: ColorConstant.black100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          content: SizedBox(
            width: 240,
            height: 200,
            child: Column(
              children: [
                const Spacer(),
                Text(
                  'プレイヤー${decidedExecuteId().assignedId}',
                  style: TextStyleConstant.normal18,
                ),
                const Text(
                  'を処刑しました',
                  style: TextStyleConstant.normal14,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.main,
                  ),
                  onPressed: () async {
                    final member = decidedExecuteId();
                    final room =
                        await ref.read(roomRepositoryProvider).getRoom(roomId);
                    ref
                        .read(roomRepositoryProvider)
                        .killMember(roomId, member.userId)
                        .then((_) {
                      isContenue(room.maxNum);
                    });
                  },
                  child: Text(
                    'OK',
                    style: TextStyleConstant.bold12
                        .copyWith(color: ColorConstant.black100),
                  ),
                ),
                const Spacer(),
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
  }
}
