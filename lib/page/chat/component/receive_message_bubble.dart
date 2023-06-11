import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';

class ReceiveMessageBubble extends StatelessWidget {
  const ReceiveMessageBubble({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          CircleAvatar(),
          SizedBox(
            width: 16.0,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorConstant.black60,
                  spreadRadius: 0.1,
                  blurRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(20),
              color: ColorConstant.purple95,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(message),
            ),
          ),
        ],
      ),
    );
  }
}
