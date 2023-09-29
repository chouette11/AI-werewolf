import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:ai_werewolf/page/chat/chat_page.dart';
import 'package:ai_werewolf/page/night/night_page.dart';
import 'package:ai_werewolf/page/root/root_page.dart';
import 'package:ai_werewolf/page/wait/make_room_page.dart';

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
            path: 'chat/:roomId/:isFirst',
            builder: (context, state) {
              final roomId = state.pathParameters['roomId'];
              final isFirst = state.pathParameters['isFirst'];
              return ChatPage(
                roomId: roomId!,
                isFirst: isFirst! == '1' ? true : false,
              );
            },
          ),
          GoRoute(
            path: 'wait/:roomId/:isJoin',
            builder: (context, state) {
              final roomId = state.pathParameters['roomId'];
              final isJoin = state.pathParameters['isJoin'];
              return WaitPage(
                roomId: roomId!,
                isJoin: isJoin! == '1' ? true : false,
              );
            },
          ),
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
