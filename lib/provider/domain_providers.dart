import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wordwolf/page/chat/chat_page.dart';
import 'package:wordwolf/page/root/root_page.dart';

final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);

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
            builder: (context, state) => ChatPage(roomId: state.extra! as String),
          ),
        ],
      ),
    ],
  ),
);
