import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/page/chat/component/end_dialog.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/room_repository.dart';

class NightDialog extends ConsumerWidget {
  const NightDialog({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));

    return members.when(
      data: (data) {
        final liveMem = ref.read(roomRepositoryProvider).getLivingMembers(data);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(seconds: 5), () {
            if (data[data.indexWhere((e) => e.userId == 'gpt')].isLive ==
                false) {
              context.pop();
              showDialog(
                context: context,
                builder: (context) => EndDialog(result: '村人'),
              );
            }
            if (liveMem.length <= 2) {
              context.pop();
              showDialog(
                context: context,
                builder: (context) => EndDialog(result: 'AI'),
              );
            }

            context.pop();
            context.push("/chat", extra: roomId);
          });
        });

        return const AlertDialog(
          backgroundColor: ColorConstant.black100,
          shape: RoundedRectangleBorder(
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
  }
}
