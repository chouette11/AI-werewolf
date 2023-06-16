import 'package:flutter/material.dart';

class EndDialog extends StatelessWidget {
  const EndDialog({Key? key, required this.result}) : super(key: key);
  final String result;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 100,
        height: 100,
        child: Text(result),
      ),
    );
  }
}
