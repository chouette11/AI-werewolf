import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PolygonWidget extends ConsumerWidget {
  const PolygonWidget(this.type, this.count, {Key? key}) : super(key: key);
  final int type;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if ((count + type) % 3 == 0) {
      return const Image(image: AssetImage('assets/images/polygon1.png'));
    } else if ((count + type) % 3 == 1) {
      return const Image(image: AssetImage('assets/images/polygon2.png'));
    } else {
      return const Image(image: AssetImage('assets/images/polygon3.png'));
    }
  }
}
