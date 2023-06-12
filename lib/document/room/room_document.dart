import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordwolf/document/timestamp_converter.dart';

part 'room_document.freezed.dart';

part 'room_document.g.dart';

@freezed
class RoomDocument with _$RoomDocument {
  const RoomDocument._();

  const factory RoomDocument({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'id') required String id,
  }) = _RoomDocument;

  factory RoomDocument.fromJson(Map<String, dynamic> json) =>
      _$RoomDocumentFromJson(json);
}
