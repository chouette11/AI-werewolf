import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/model/entity/member/member_entity.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';

class ExecutedDialog extends ConsumerWidget {
  const ExecutedDialog({
    Key? key,
    required this.roomId,
    required this.members,
  }) : super(key: key);
  final String roomId;
  final List<MemberEntity> members;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));

    return members.when(
      data: (data) {
        MemberEntity decidedExecuteMem() {
          data.sort((a, b) => -a.voted.compareTo(b.voted));
          return data[0];
        }

        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: ColorConstant.back,
            content: SizedBox(
              width: 240,
              height: 200,
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    'プレイヤー${decidedExecuteMem().assignedId}',
                    style: TextStyleConstant.normal18,
                  ),
                  const Text(
                    'を処刑しました',
                    style: TextStyleConstant.normal14,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ColorConstant.main,
                      backgroundColor: ColorConstant.accent,
                    ),
                    onPressed: () {
                      context.pop();
                      context.go('/night', extra: roomId);
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
