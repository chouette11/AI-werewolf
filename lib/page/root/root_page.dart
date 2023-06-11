import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("ワードウルフ"),
          ElevatedButton(
            onPressed: () => context.push("/chat"),
            child: const Text("始める"),
          ),
        ],
      ),
    );
  }
}
