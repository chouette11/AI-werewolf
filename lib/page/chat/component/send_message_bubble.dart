import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class SendMessageBubble extends StatelessWidget {
  const SendMessageBubble({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
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
            color: ColorConstant.main,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              style: TextStyleConstant.normal16.copyWith(
                color: ColorConstant.black100,
              )
            ),
          ),
        ),
      ),
    );
  }
}
