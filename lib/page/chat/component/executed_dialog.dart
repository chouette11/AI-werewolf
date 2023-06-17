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

        String isContenue() {
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
                    Text(
                      'を処刑しました',
                      style: TextStyleConstant.normal14,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.main,
                      ),
                      onPressed: () async {
                        final member = decidedExecuteId();
                        final room = await ref.read(roomRepositoryProvider).getRoom(roomId);
                        await ref.read(messageRepositoryProvider).deleteAllMessage(roomId);
                        final maxNum = room.maxNum;
                        final liveMem = [];
                        for (var e in data) {
                          if (e.isLive == true) {
                            liveMem.add(e);
                          }
                        }
                        await ref
                            .read(roomRepositoryProvider)
                            .killMember(roomId, member.userId);
                        if (isContenue() == '続く') {
                          final uid = ref.read(uidProvider);
                          if (data[
                          data.indexWhere((e) => e.userId != 'gpt')].userId == uid) {
                            ref.read(roomRepositoryProvider).randomKill(roomId);
                          }
                          ref.read(limitTimeProvider.notifier).reset();
                          context.pop();
                          showDialog(
                            context: context,
                            builder: (context) => NightDialog(
                              roomId: roomId,
                              liveMem: data,
                              reqUid: data[
                                      data.indexWhere((e) => e.userId != 'gpt')]
                                  .userId,
                              maxNum: maxNum,
                            ),
                          );
                        } else if (isContenue() == '村人') {
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
      },
      error: (error, stackTrace) {
        return const Text('エラーが発生しました');
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
