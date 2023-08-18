import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wordwolf/page/chat/chat_page.dart';
import 'package:wordwolf/page/night/night_page.dart';
import 'package:wordwolf/page/root/root_page.dart';
import 'package:wordwolf/page/start/make_room_page.dart';

final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);

final uuidProvider = Provider((_) => const Uuid());

/// ページ遷移のプロバイダ
final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RootPage(),
        routes: [
          GoRoute(
            path: 'chat/:isFirst',
            builder: (context, state) {
              final isFirst = state.pathParameters['isFirst'];
              return ChatPage(
                roomId: state.extra! as String,
                isFirst: isFirst == 'true' ? true : false,
              );
            },
          ),
          GoRoute(
              path: 'make',
              builder: (context, state) =>
                  MakeRoomPage(roomId: state.extra! as String)),
          GoRoute(
            path: 'night',
            builder: (context, state) =>
                NightPage(roomId: state.extra! as String),
          ),
        ],
      ),
    ],
  ),
);
