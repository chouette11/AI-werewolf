import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class JoinDialog extends StatelessWidget {
  const JoinDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstant.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      content: const SizedBox(
        width: 240,
        height: 160,
        child: Column(
          children: [
            Text(
              '参加ID',
              style: TextStyleConstant.normal32,
            ),
            SizedBox(height: 56),
            SizedBox(
              height: 40,
              width: 224,
              child: TextField(
                textAlign: TextAlign.left,
                autofocus: true,
                cursorColor: ColorConstant.main,
                decoration: InputDecoration(
                  fillColor: ColorConstant.base,
                  filled: true,
                  hintText: 'IDを入力',
                  hintStyle:
                      TextStyle(fontSize: 16, color: ColorConstant.black0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: ColorConstant.black0,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
            height: 48,
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "参加する",
                style: TextStyleConstant.normal16.copyWith(
                  color: ColorConstant.black100,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 24,)
      ],
    );
  }
}
