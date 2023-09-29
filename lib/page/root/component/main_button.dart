import 'package:flutter/material.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConstant.black0,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/main_button2.png'),
            Text(
              text,
              style: TextStyleConstant.normal24,
            ),
          ],
        ),
      ),
    );
  }
}
