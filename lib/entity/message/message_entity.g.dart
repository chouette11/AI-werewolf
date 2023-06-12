// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageEntity _$$_MessageEntityFromJson(Map<String, dynamic> json) =>
    _$_MessageEntity(
      content: json['content'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_MessageEntityToJson(_$_MessageEntity instance) =>
    <String, dynamic>{
      'content': instance.content,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
