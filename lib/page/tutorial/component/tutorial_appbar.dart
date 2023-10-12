import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ai_werewolf/util/constant/text_style_constant.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';

class TutorialAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TutorialAppBar(this.counter, {super.key});
  final int counter;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AppBar(
      backgroundColor: ColorConstant.back,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'お題',
                style: TextStyleConstant.normal12,
              ),
              Text(
                '「うどん」',
                style: TextStyleConstant.normal16,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 88,
                child: Text(
                  'ID 00000',
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
                          SvgPicture.asset('assets/images/timer_box.svg'),
                          SizedBox(
                            width: 80,
                            child: Center(
                              child: Text(
                                counter >= 0 ? counter.toString() : '0',
                                style: TextStyleConstant.normal28
                                    .copyWith(color: ColorConstant.black30),
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
                  Stack(
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
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
