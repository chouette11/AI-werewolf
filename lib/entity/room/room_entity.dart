import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordwolf/document/room/room_document.dart';

part 'room_entity.freezed.dart';
part 'room_entity.g.dart';


@freezed
class RoomEntity with _$RoomEntity {
    const RoomEntity._();

  const factory RoomEntity({
    required String id,
  }) = _RoomEntity;

   factory RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomEntityFromJson(json);

  static RoomEntity fromDoc(RoomDocument roomDoc) {
    return RoomEntity(
      id: roomDoc.id,
    );
  }

  RoomDocument toRoomDocument() {
    return RoomDocument(
      id: id, 
      maxNum: 4, 
      members: {},
    );
  }
}
