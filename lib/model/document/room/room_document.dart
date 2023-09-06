import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordwolf/model/document/timestamp_converter.dart';

part 'room_document.freezed.dart';

part 'room_document.g.dart';

@freezed
class RoomDocument with _$RoomDocument {
  const RoomDocument._();

  const factory RoomDocument({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'topic') required String topic,
    @JsonKey(name: 'maxNum') required int maxNum,
    @JsonKey(name: 'roles') required List<String> roles,
    @JsonKey(name: 'votedSum') required int votedSum,
    @JsonKey(name: 'killedId') required int killedId,
    @TimestampConverter() @JsonKey(name: 'startTime') required DateTime startTime,

  }) = _RoomDocument;

  factory RoomDocument.fromJson(Map<String, dynamic> json) =>
      _$RoomDocumentFromJson(json);
}
