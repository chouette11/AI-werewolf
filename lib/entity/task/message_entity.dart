import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String content,
    required String userId,
    required DateTime createdAt,
  }) = _MessageEntity;
}
