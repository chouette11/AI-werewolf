import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ai_werewolf/page/chat/component/role_dialog.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';

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
                  SizedBox(
                    width: 88,
                    child: Text(
                      'ID $roomId',
                      style: TextStyleConstant.normal12,
                    ),
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
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/images/timer_box.svg'),
                              SizedBox(
                                width: 80,
                                child: Center(
                                  child: Text(
                                    counter >= 0 ? counter.toString() : '0',
                                    style: TextStyleConstant.normal28
                                        .copyWith(
                                            color: ColorConstant.black30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => RoleDialog(roomId, true),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/role_button2.png',
                              height: 32,
                            ),
                            const Text(
                              '役職',
                              style: TextStyleConstant.normal16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
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
