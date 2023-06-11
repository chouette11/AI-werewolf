

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/page/chat/chat_page.dart';
import 'package:wordwolf/page/root/root_page.dart';


/// ページ遷移のプロバイダ
final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RootPage(),
        routes: [
          GoRoute(
            path: 'chat',
            builder: (context, state) => const ChatPage(),
          ),
        ],
      ),
    ],
  ),
);
