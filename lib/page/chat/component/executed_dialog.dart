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
                  const Text('処刑', style: TextStyleConstant.normal14),
                  Text(
                    'プレイヤー${decidedExecuteMem().assignedId}',
                    style: TextStyleConstant.normal20,
                  ),
                  const SizedBox(height: 24),
                  Image.asset('assets/images/execute.png'),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      context.go('/night', extra: roomId);
                    },
                    child: Container(
                      width: 56,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: ColorConstant.accent,
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstant.black10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Text(
                        'OK',
                        style: TextStyleConstant.normal12,
                      )),
                    ),
                  ),
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
