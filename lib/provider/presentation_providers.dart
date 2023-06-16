import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wordwolf/entity/member/member_entity.dart';
import 'package:wordwolf/repository/message_repository.dart';
import 'package:wordwolf/repository/room_repository.dart';

part 'presentation_providers.g.dart';

final messageTextFieldProvider = StateProvider<String>((ref) => '');

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
      ref.watch(roomRepositoryProvider).getRoomMemberStream(roomId),
);

final answerRadioValueProvider = StateProvider<String>((ref) => '');

final maxMemberProvider = StateProvider<int>((ref) => 3);

final topicProvider = StateProvider((ref) => 'うどん');

final isMakeRoomProvider = StateProvider<bool>((ref) => false);

@riverpod
class LimitTime extends _$LimitTime {
  @override
  int build() {
    return 90;
  }

  void reset() {
    state = 90;
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
