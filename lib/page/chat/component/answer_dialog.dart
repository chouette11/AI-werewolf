import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/member_repository.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';

class AnswerDialog extends ConsumerStatefulWidget {
  const AnswerDialog({super.key, required this.roomId});

  final String roomId;

  @override
  ConsumerState<AnswerDialog> createState() => _AnswerDialogState();
}

class _AnswerDialogState extends ConsumerState<AnswerDialog> {
  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(answerAssignedIdProvider);
    final members = ref.watch(membersStreamProvider(widget.roomId));
    final room = ref.watch(roomStreamProvider(widget.roomId));

    return members.when(
      data: (data) {
        final livingMem =
            ref.read(memberRepositoryProvider).getLivingMembers(data);
        // プレイヤーxのxでソート
        livingMem.sort((a, b) => a.assignedId.compareTo(b.assignedId));
        return room.when(
          data: (room) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: ColorConstant.back,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          ...livingMem
                              .map((member) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(answerAssignedIdProvider
                                                    .notifier)
                                                .update((state) =>
                                                    member.assignedId);
                                          },
                                          child: ChoicesWidget(
                                              assignedId: member.assignedId)),
                                      const SizedBox(height: 16)
                                    ],
                                  ))
                              .toList(),
                          isSend
                              ? Text(
                                  '全員が投票するまでおまちください',
                                  style: TextStyleConstant.normal12
                                      .copyWith(color: ColorConstant.accent),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: value == 404 || isSend
                                ? null
                                : () {
                                    ref
                                        .read(memberRepositoryProvider)
                                        .voteForMember(widget.roomId, value);
                                    isSend = true;
                                    setState(() {});
                                  },
                            child: Container(
                              width: 56,
                              height: 32,
                              decoration: BoxDecoration(
                                color: value == 404 || isSend
                                    ? ColorConstant.black20
                                    : ColorConstant.accent,
                                boxShadow: const [
                                  BoxShadow(
                                    color: ColorConstant.black10,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: const Center(
                                  child: Text(
                                '決定',
                                style: TextStyleConstant.normal12,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset('assets/images/vote.png')
                ],
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

class ChoicesWidget extends ConsumerWidget {
  const ChoicesWidget({Key? key, required this.assignedId}) : super(key: key);
  final int assignedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(answerAssignedIdProvider);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 40,
          width: 200,
          child: Stack(
            children: [
              Positioned(
                top: 1,
                left: 3,
                child: SizedBox(
                    height: 40,
                    width: 180,
                    child: Image.asset('assets/images/shadow.png')),
              ),
              value == assignedId
                  ? Image.asset('assets/images/selected.png')
                  : Image.asset('assets/images/not_selected.png'),
            ],
          ),
        ),
        SizedBox(
          height: 32,
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.black90,
                    ),
                    width: 16.5,
                    height: 16.5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getChatColor(assignedId),
                    ),
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
              Text(
                'プレイヤー$assignedId',
                style: TextStyleConstant.normal16.copyWith(
                  color: ColorConstant.black0,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
