import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/model/constant/text_style_constant.dart';
import 'package:wordwolf/model/constant/color_constant.dart';
import 'package:wordwolf/model/entity/message/message_entity.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

class SendMessageBubble extends ConsumerWidget {
  const SendMessageBubble({
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));

    Widget bubbleSize() {
      final textWidth = _textSize(messageEntity.content).width;
      if (textWidth < MediaQuery.of(context).size.width * 0.5) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            messageEntity.content,
            style: TextStyleConstant.normal16
                .copyWith(color: ColorConstant.black10),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8),
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

    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 6, bottom: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  borderRadius: const BorderRadius.all(Radius.circular(1)),
                  color: ColorConstant.black100,
                  border: Border.all(color: ColorConstant.black0, width: 1)),
              child: bubbleSize(),
            ),
            const SizedBox(width: 12),
            members.when(
              data: (data) {
                if (data.indexWhere((e) => e.userId == messageEntity.userId) ==
                    -1) {
                  return const SizedBox.shrink();
                }
                final member = data[
                    data.indexWhere((e) => e.userId == messageEntity.userId)];
                return Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.black100,
                    border: Border.all(color: ColorConstant.black0, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      member.assignedId.toString(),
                      style: TextStyleConstant.normal18
                          .copyWith(color: ColorConstant.black10),
                    ),
                  ),
                );
              },
              error: (_, __) => Text(_.toString()),
              loading: () => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
