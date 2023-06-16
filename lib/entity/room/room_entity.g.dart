// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoomEntity _$$_RoomEntityFromJson(Map<String, dynamic> json) =>
    _$_RoomEntity(
      id: json['id'] as String,
      maxNum: json['maxNum'] as int,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_RoomEntityToJson(_$_RoomEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'maxNum': instance.maxNum,
      'roles': instance.roles,
    };
