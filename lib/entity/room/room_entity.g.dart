// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoomEntity _$$_RoomEntityFromJson(Map<String, dynamic> json) =>
    _$_RoomEntity(
      id: json['id'] as String,
      topic: json['topic'] as String,
      maxNum: json['maxNum'] as int,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      votedSum: json['votedSum'] as int,
    );

Map<String, dynamic> _$$_RoomEntityToJson(_$_RoomEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'maxNum': instance.maxNum,
      'roles': instance.roles,
      'votedSum': instance.votedSum,
    };
