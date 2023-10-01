import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultUsers extends ConsumerWidget {
  const ResultUsers({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));
    return members.when(
      data: (data) {
        data.sort((a, b) => a.assignedId.compareTo(b.assignedId));
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...data.map(
              (member) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _borderColor(member.assignedId),
                        border: Border.all(color: ColorConstant.black0, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          member.assignedId.toString(),
                          style: TextStyleConstant.normal20
                              .copyWith(color: ColorConstant.black10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(member.role, style: TextStyleConstant.bold14)
                  ],
                ),
              ),
            ),
          ],
        );
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

Color _borderColor(int assignedUserId) {
  switch (assignedUserId) {
    case 1:
      return ColorConstant.chat1;
    case 2:
      return ColorConstant.chat2;
    case 3:
      return ColorConstant.chat3;
    case 4:
      return ColorConstant.chat4;
    case 5:
      return ColorConstant.chat5;
    default:
      return ColorConstant.black100;
  }
}
