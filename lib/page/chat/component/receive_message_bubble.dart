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
      child: Row(
        children: [
          members.when(
            data: (data) {
              return Text(
                /// Todo nullになぜなるか
                data[messageEntity.userId] == null
                    ? ''
                    : data[messageEntity.userId]!.toString(),
                style: const TextStyle(fontSize: 32),
              );
            },
            loading: () => const Text('loading'),
            error: (error, stackTrace) => Text(error.toString()),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorConstant.secondary,
                  spreadRadius: 0.1,
                  blurRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(24),
              color: ColorConstant.secondary,
            ),
            child: bubbleSize(),
          ),
        ],
      ),
    );
  }
}
