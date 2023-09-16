import 'package:flutter/material.dart';
import 'package:wordwolf/util/constant/text_style_constant.dart';

class TitleIcon extends StatelessWidget {
  const TitleIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset('assets/images/title_icon.png', height: 270),
        const Text(
          'AI人狼',
          style: TextStyleConstant.bold48,
        )
      ],
    );
  }
}
