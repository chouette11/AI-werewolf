import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class ReceiveMessageBubble extends StatelessWidget {
  const ReceiveMessageBubble({Key? key, required this.message})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          const CircleAvatar(),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 200,
                child: Text(
                  message,
                  style: TextStyleConstant.normal16,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
