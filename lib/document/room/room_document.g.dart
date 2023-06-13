// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoomDocument _$$_RoomDocumentFromJson(Map<String, dynamic> json) =>
    _$_RoomDocument(
      id: json['id'] as String,
      maxNum: json['maxNum'] as int,
      members: Map<String, int>.from(json['members'] as Map),
    );

Map<String, dynamic> _$$_RoomDocumentToJson(_$_RoomDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'maxNum': instance.maxNum,
      'members': instance.members,
    };
