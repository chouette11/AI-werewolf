import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordwolf/document/timestamp_converter.dart';

part 'message_document.freezed.dart';

part 'message_document.g.dart';

@freezed
class MessageDocument with _$MessageDocument {
  const MessageDocument._();

  const factory MessageDocument({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'content') required String content,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'userId') required String userId,
    // ignore: invalid_annotation_target
    @TimestampConverter() @JsonKey(name: 'createdAt') required DateTime createdAt,
  }) = _MessageDocument;

  factory MessageDocument.fromJson(Map<String, dynamic> json) =>
      _$MessageDocumentFromJson(json);
}
