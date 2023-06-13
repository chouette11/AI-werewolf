// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoomEntity _$$_RoomEntityFromJson(Map<String, dynamic> json) =>
    _$_RoomEntity(
      id: json['id'] as String,
      members: Map<String, int>.from(json['members'] as Map),
      maxNum: json['maxNum'] as int,
    );

Map<String, dynamic> _$$_RoomEntityToJson(_$_RoomEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'members': instance.members,
      'maxNum': instance.maxNum,
    };
