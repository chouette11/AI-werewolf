import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/model/constant/text_style_constant.dart';
import 'package:wordwolf/model/constant/color_constant.dart';
import 'package:wordwolf/model/entity/member/member_entity.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

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
                    backgroundColor: ColorConstant.main,
                  ),
                  onPressed: () {
                    context.push('/night', extra: roomId);
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
