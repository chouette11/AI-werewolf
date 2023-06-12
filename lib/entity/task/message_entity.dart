import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordwolf/document/message/message_document.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';


@freezed
class MessageEntity with _$MessageEntity {
    const MessageEntity._();

  const factory MessageEntity({
    required String content,
    required String userId,
    required DateTime createdAt,
  }) = _MessageEntity;

   factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

  static MessageEntity fromDoc(MessageDocument taskDoc) {
    return MessageEntity(
      content: taskDoc.content,
      userId: taskDoc.userId,
      createdAt: taskDoc.createdAt,
    );
  }

  MessageDocument toMessageDocument() {
    return MessageDocument(
      content: content,
      userId: userId,
      createdAt: createdAt,
    );
  }
}
