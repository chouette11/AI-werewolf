import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wordwolf/entity/task/message_entity.dart';

part 'presentation_providers.g.dart';

@riverpod
class Messages extends _$Messages {
  @override
  List<MessageEntity> build() {
    return [];
  }

  // Let's allow the UI to add messages.
  void addMessage(String message) {
    final entity = MessageEntity(content: "${state.length}", userId: state.length == 3 ? "my" : "other", createdAt: DateTime.now());
    state = [...state, entity];
  }
}

final exampleTextFieldProvider = StateProvider<String>((ref) => '');
