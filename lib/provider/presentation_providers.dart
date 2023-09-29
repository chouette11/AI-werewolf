import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_werewolf/model/entity/member/member_entity.dart';
import 'package:ai_werewolf/repository/member_repository.dart';
import 'package:ai_werewolf/repository/message_repository.dart';
import 'package:ai_werewolf/repository/room_repository.dart';
import 'package:ai_werewolf/util/constant/const.dart';

part 'presentation_providers.g.dart';

final messageTextFieldController = Provider((_) => TextEditingController());

final idTextFieldProvider = StateProvider<String>((ref) => '');

final startTextFieldProvider = StateProvider((ref) => '');

final uidProvider = StateProvider<String>((ref) => '');

final errorTextProvider = StateProvider((ref) => '');

final messagesStreamProvider = StreamProvider.family(
  (ref, String roomId) =>
      ref.watch(messageRepositoryProvider).getMessageStream(roomId),
);

final membersStreamProvider = StreamProvider.family<List<MemberEntity>, String>(
  (ref, String roomId) =>
      ref.watch(memberRepositoryProvider).getRoomMemberStream(roomId),
);

final randomKillProvider =
    FutureProvider.family<int, String>((ref, String roomId) async {
  final isHost = ref.read(isMakeRoomProvider);
  int killedUserAssignedId = 404;
  if (isHost) {
    print('kill_before');
    await ref.read(memberRepositoryProvider).randomKill(roomId);
    print('kill_after');
  }
  final livingMem =
      await ref.watch(memberRepositoryProvider).getLivingMembersFromDB(roomId);
  if (killedUserAssignedId == 404) {
    return 404;
  } else if (livingMem.indexWhere((e) => e.userId == 'gpt') == -1) {
    return 100;
  } else if (livingMem.length <= 2) {
    return 200;
  } else {
    return 300;
  }
});

final memberStreamProvider = StreamProvider.family<MemberEntity, String>(
  (ref, String roomId) =>
      ref.watch(memberRepositoryProvider).getMemberStream(roomId),
);

final roomStreamProvider = StreamProvider.family(
  (ref, String roomId) =>
      ref.watch(roomRepositoryProvider).getRoomStream(roomId),
);

final answerAssignedIdProvider = StateProvider<int>((ref) => 404);

final maxMemberProvider = StateProvider<int>((ref) => 3);

final topicProvider =
    FutureProvider.family<String, String>((ref, String roomId) async {
  final room = await ref.read(roomRepositoryProvider).getRoom(roomId);
  return room.topic;
});

final isMakeRoomProvider = StateProvider<bool>((ref) => false);

final limitTimerProvider = StateProvider.family((ref, DateTime startTime) {
  final now = new DateTime.now();
  print(now);
  return now.difference(startTime);
});

@riverpod
class LimitTime extends _$LimitTime {
  @override
  int build() {
    const flavor = String.fromEnvironment('flavor');
    if (flavor == 'tes') {
      return 10;
    }
    return 100;
  }

  void reset() {
    state = 100;
    const flavor = String.fromEnvironment('flavor');
    if (flavor == 'tes') {
      state = 10;
    }
  }

  void startTimer(DateTime startTime) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      const flavor = String.fromEnvironment('flavor');
      final time = DateTime.now().difference(startTime);
      state =
          (flavor == 'tes' ? 10 : 100) + ROLE_DIALOG_TIME + 1 - time.inSeconds;
      if (state < 1) {
        timer.cancel();
      }
    });
  }
}
