import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordwolf/model/constant/text_style_constant.dart';
import 'package:wordwolf/model/constant/color_constant.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

class ChatAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topic = ref.watch(topicProvider(roomId));
    final counter = ref.watch(limitTimeProvider);

    return AppBar(
      backgroundColor: ColorConstant.back,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 80,
      title: topic.when(
        data: (topic) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'お題',
                        style: TextStyleConstant.normal12,
                      ),
                      Text(
                        '「$topic」',
                        style: TextStyleConstant.normal16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID $roomId',
                        style: TextStyleConstant.normal12,
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            const SizedBox(height: 4),
                            Container(
                              decoration: const BoxDecoration(
                                color: ColorConstant.black100,
                              ),
                              child: Stack(
                                children: [
                                  SvgPicture.asset('assets/images/timer_box.svg'),
                                  Positioned(
                                    top: 6,
                                    child: SizedBox(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          counter.toString(),
                                          style: TextStyleConstant.normal28
                                              .copyWith(color: ColorConstant.black30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48,)
                    ],
                  ),
                ],
              ),
            ],
          );
        },
        error: (_, __) => const Text('error'),
        loading: () => const SizedBox.shrink(),
      ),
    );
  }
}
