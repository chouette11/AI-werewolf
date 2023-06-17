import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/entity/member/member_entity.dart';
import 'package:wordwolf/page/chat/component/end_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class NightDialog extends ConsumerStatefulWidget {
  const NightDialog({
    super.key,
    required this.roomId,
    required this.members,
  });

  final String roomId;
  final List<MemberEntity> members;

  @override
  ConsumerState<NightDialog> createState() => _NightDialogState();
}

class _NightDialogState extends ConsumerState<NightDialog> {
  @override
  void initState() {
    ref.read(roomRepositoryProvider).randomKill(widget.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final room = ref.watch(roomStreamProvider(widget.roomId));

    return members.when(
      data: (data) {
        if (data.length == widget.members.length - 1) {
          if (data[data.indexWhere((e) => e.userId == 'gpt')].isLive == false) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) => EndDialog(result: '村人'),
            );
          }
          if (data.length <= 2) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) => EndDialog(result: 'AI'),
            );
          }
          context.pop();
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
                height: 400,
                child: Column(
                  children: [Text('AIが惨殺しています。しばらくお待ち下さい')],
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
