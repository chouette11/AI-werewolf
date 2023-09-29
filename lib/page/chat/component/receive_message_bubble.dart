import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/model/entity/message/message_entity.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';

class ReceiveMessageBubble extends ConsumerWidget {
  const ReceiveMessageBubble({
    Key? key,
    required this.messageEntity,
    required this.roomId,
  }) : super(key: key);
  final MessageEntity messageEntity;
  final String roomId;

  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Color borderColor(int assignedUserId) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget bubbleSize() {
      final textWidth = _textSize(messageEntity.content).width;
      if (textWidth < MediaQuery.of(context).size.width * 0.5) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            messageEntity.content,
            style: TextStyleConstant.normal16
                .copyWith(color: ColorConstant.black10),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              messageEntity.content,
              style: TextStyleConstant.normal16
                  .copyWith(color: ColorConstant.black10),
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }

    final members = ref.watch(membersStreamProvider(roomId));
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
      child: members.when(
        data: (data) {
          if (data.indexWhere((e) => e.uid == messageEntity.uid) == -1) {
            return const SizedBox.shrink();
          }
          final member =
              data[data.indexWhere((e) => e.uid == messageEntity.uid)];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: borderColor(member.assignedId),
                  border: Border.all(color: ColorConstant.black0, width: 1),
                ),
                child: Center(
                  child: Text(
                    member.assignedId.toString(),
                    style: TextStyleConstant.normal18
                        .copyWith(color: ColorConstant.black10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: ColorConstant.black20,
                      offset: Offset(0, 4),
                      spreadRadius: 1,
                      blurRadius: 4,
                    )
                  ],
                  borderRadius: BorderRadius.circular(1),
                  color: borderColor(member.assignedId),
                  border: Border.all(
                    color: ColorConstant.black0,
                    width: 1,
                  ),
                ),
                child: bubbleSize(),
              ),
            ],
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stackTrace) => Text(error.toString()),
      ),
    );
  }
}
