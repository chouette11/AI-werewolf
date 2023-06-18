import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class DiedDialog extends StatelessWidget {
  const DiedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: ColorConstant.secondary,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Spacer(),
            Text(
              'あなたは死にました（一般人）',
              style: TextStyleConstant.bold12,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
