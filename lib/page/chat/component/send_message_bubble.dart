import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class SendMessageBubble extends StatelessWidget {
  const SendMessageBubble({Key? key, required this.message}) : super(key: key);
  final String message;
  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    Widget bubbleSize() {
      final textWidth = _textSize(message).width;
      if (textWidth < MediaQuery.of(context).size.width * 0.5) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message,
            style: TextStyleConstant.normal16,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              message,
              style: TextStyleConstant.normal16,
              overflow: TextOverflow.visible,
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorConstant.black60,
                spreadRadius: 0.1,
                blurRadius: 1,
              )
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
            color: ColorConstant.secondary,
          ),
          child: bubbleSize(),
        ),
      ),
    );
  }
}
