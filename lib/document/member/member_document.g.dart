// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MemberDocument _$$_MemberDocumentFromJson(Map<String, dynamic> json) =>
    _$_MemberDocument(
      userId: json['userId'] as String,
      assignedId: json['assignedId'] as int,
      role: json['role'] as String,
      isLive: json['isLive'] as bool,
      voted: json['voted'] as int,
    );

Map<String, dynamic> _$$_MemberDocumentToJson(_$_MemberDocument instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'assignedId': instance.assignedId,
      'role': instance.role,
      'isLive': instance.isLive,
      'voted': instance.voted,
    };
