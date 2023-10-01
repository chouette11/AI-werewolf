import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:flutter/material.dart';

class BackTitleButton extends StatelessWidget {
  const BackTitleButton({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 24,
            width: 24,
            child: Stack(
              children: [
                Positioned(
                  top: 3,
                  left: 2,
                  child: Image(
                      image: AssetImage('assets/images/polygon_shadow.png')),
                ),
                Image(image: AssetImage('assets/images/polygon3.png')),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'タイトルへ戻る',
            style: TextStyleConstant.normal20.copyWith(
              shadows: [
                const Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 4.0,
                  color: ColorConstant.black0
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
