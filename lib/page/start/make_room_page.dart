import 'package:flutter/material.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';

class MakeRoomPage extends StatelessWidget {
  const MakeRoomPage({Key? key, required this.roomId}) : super(key: key);
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.back,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('ROOM ID', style: TextStyleConstant.normal24),
          const SizedBox(height: 8),
          Text(roomId, style: TextStyleConstant.bold48),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.share, color: ColorConstant.main),
              SizedBox(width: 20),
              Icon(Icons.copy, color: ColorConstant.main),
            ],
          ),
          const SizedBox(height: 48),
          const Text('メンバー待機中...', style: TextStyleConstant.normal18),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_outline, color: ColorConstant.main, size: 40),
              SizedBox(width: 32),
              Image(image: AssetImage('assets/images/polygon1.png')),
              SizedBox(width: 16),
              Image(image: AssetImage('assets/images/polygon2.png')),
              SizedBox(width: 16),
              Image(image: AssetImage('assets/images/polygon3.png')),
              SizedBox(width: 32),
              Icon(Icons.group_outlined, color: ColorConstant.main, size: 40),
            ],
          )
        ],
      ),
    );
  }
}
