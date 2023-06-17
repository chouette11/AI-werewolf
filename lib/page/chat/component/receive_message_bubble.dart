import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/entity/message/message_entity.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Text(
            messageEntity.content,
            style: TextStyleConstant.normal16,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              messageEntity.content,
              style: TextStyleConstant.normal16,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }

    final members = ref.watch(membersStreamProvider(roomId));
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: members.when(
        data: (data) {
          if (data.indexWhere((e) => e.userId == messageEntity.userId) == -1) {
            return const SizedBox.shrink();
          }
          final member =
              data[data.indexWhere((e) => e.userId == messageEntity.userId)];
          return Row(
            children: [
              const SizedBox(width: 8),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: borderColor(int.parse(member.assignedId)),
                ),
                child: Center(
                  child: Text(
                    member.assignedId,
                    style: TextStyleConstant.normal24,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: ColorConstant.black70,
                      spreadRadius: 0.1,
                      blurRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.circular(24),
                  color: ColorConstant.black100,
                  border: Border.all(
                    color: borderColor(int.parse(member.assignedId)),
                    width: 2,
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
