import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

class ChatAppBar extends ConsumerStatefulWidget {
  const ChatAppBar({super.key, required this.roomId});
  final String roomId;

  @override
  ConsumerState<ChatAppBar> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatAppBar> {

  @override
  Widget build(BuildContext context) {
    final topic = ref.watch(topicProvider);
    final counter = ref.watch(limitTimeProvider);

    return AppBar(
      backgroundColor: ColorConstant.main,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        children: [
          Text("お題は$topic",
              style: TextStyleConstant.bold16.copyWith(
                color: ColorConstant.black100,
              )),
          const Spacer(),
          Text('残り',
              style: TextStyleConstant.normal12.copyWith(
                color: ColorConstant.black100,
              )),
          Text(counter >= 0 ? counter.toString() : '0',
              style: TextStyleConstant.bold16.copyWith(
                color: ColorConstant.black100,
              )),
          Text('秒',
              style: TextStyleConstant.bold16.copyWith(
                color: ColorConstant.black100,
              )),
          const Spacer(),
          Text(
            'ID:',
            style: TextStyleConstant.normal12.copyWith(
              color: ColorConstant.black100,
            ),
          ),
          Text(
            widget.roomId,
            style: TextStyleConstant.normal14
                .copyWith(color: ColorConstant.black100),
          ),
        ],
      ),
    );
  }
}
