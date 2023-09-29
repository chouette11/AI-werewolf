import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ai_werewolf/model/document/room/room_document.dart';

part 'room_entity.freezed.dart';

part 'room_entity.g.dart';

@freezed
class RoomEntity with _$RoomEntity {
  const RoomEntity._();

  const factory RoomEntity({
    required String id,
    required String topic,
    required int maxNum,
    required List<String> roles,
    required int votedSum,
    required int killedId,
    required DateTime startTime,
  }) = _RoomEntity;

  factory RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomEntityFromJson(json);

  static RoomEntity fromDoc(RoomDocument roomDoc) {
    return RoomEntity(
      id: roomDoc.id,
      topic: roomDoc.topic,
      maxNum: roomDoc.maxNum,
      roles: roomDoc.roles,
      votedSum: roomDoc.votedSum,
      killedId: roomDoc.killedId,
      startTime: roomDoc.startTime,
    );
  }

  RoomDocument toRoomDocument() {
    return RoomDocument(
      id: id,
      topic: topic,
      maxNum: maxNum,
      roles: roles,
      votedSum: votedSum,
      killedId: killedId,
      startTime: startTime,
    );
  }
}
