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
  if (isHost) {
    await ref.read(memberRepositoryProvider).randomKill(roomId);
  }
  final livingMem =
      await ref.watch(memberRepositoryProvider).getLivingMembersFromDB(roomId);
  if (livingMem[livingMem.indexWhere((e) => e.userId == 'gpt')].isLive ==
      false) {
    return 0;
  } else if (livingMem.length <= 2) {
    return 1;
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
    return 10;
  }

  void reset() {
    state = 10;
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
