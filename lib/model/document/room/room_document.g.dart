// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoomDocument _$$_RoomDocumentFromJson(Map<String, dynamic> json) =>
    _$_RoomDocument(
      id: json['id'] as String,
      topic: json['topic'] as String,
      maxNum: json['maxNum'] as int,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      votedSum: json['votedSum'] as int,
      killedId: json['killedId'] as int,
      startTime:
          const TimestampConverter().fromJson(json['startTime'] as Timestamp),
    );

Map<String, dynamic> _$$_RoomDocumentToJson(_$_RoomDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'maxNum': instance.maxNum,
      'roles': instance.roles,
      'votedSum': instance.votedSum,
      'killedId': instance.killedId,
      'startTime': const TimestampConverter().toJson(instance.startTime),
    };
