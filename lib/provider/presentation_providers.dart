import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wordwolf/entity/member/member_entity.dart';
import 'package:wordwolf/repository/member_repository.dart';
import 'package:wordwolf/repository/message_repository.dart';
import 'package:wordwolf/repository/room_repository.dart';

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

final answerRadioValueProvider = StateProvider<String>((ref) => '');

final maxMemberProvider = StateProvider<int>((ref) => 3);

final topicProvider =
    FutureProvider.family<String, String>((ref, String roomId) async {
  final room = await ref.read(roomRepositoryProvider).getRoom(roomId);
  return room.topic;
});

final isMakeRoomProvider = StateProvider<bool>((ref) => false);

@riverpod
class LimitTime extends _$LimitTime {
  @override
  int build() {
    return 60;
  }

  void reset() {
    state = 60;
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      state = state - 1;
      if (state < 0) {
        timer.cancel();
      }
    });
  }
}
