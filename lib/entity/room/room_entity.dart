import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordwolf/document/room/room_document.dart';

part 'room_entity.freezed.dart';
part 'room_entity.g.dart';


@freezed
class RoomEntity with _$RoomEntity {
    const RoomEntity._();

  const factory RoomEntity({
    required String id,
    required Map<String, int> members,
    required int maxNum,
  }) = _RoomEntity;

   factory RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomEntityFromJson(json);

  static RoomEntity fromDoc(RoomDocument roomDoc) {
    return RoomEntity(
      id: roomDoc.id,
      members: roomDoc.members,
      maxNum: roomDoc.maxNum,
    );
  }

  RoomDocument toRoomDocument() {
    return RoomDocument(
      id: id, 
      maxNum: maxNum,
      members: members,
    );
  }
}
