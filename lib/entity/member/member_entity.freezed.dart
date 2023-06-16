// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MemberEntity {
  String get userId => throw _privateConstructorUsedError;
  String get assignedId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MemberEntityCopyWith<MemberEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberEntityCopyWith<$Res> {
  factory $MemberEntityCopyWith(
          MemberEntity value, $Res Function(MemberEntity) then) =
      _$MemberEntityCopyWithImpl<$Res, MemberEntity>;
  @useResult
  $Res call({String userId, String assignedId});
}

/// @nodoc
class _$MemberEntityCopyWithImpl<$Res, $Val extends MemberEntity>
    implements $MemberEntityCopyWith<$Res> {
  _$MemberEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? assignedId = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      assignedId: null == assignedId
          ? _value.assignedId
          : assignedId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MemberEntityCopyWith<$Res>
    implements $MemberEntityCopyWith<$Res> {
  factory _$$_MemberEntityCopyWith(
          _$_MemberEntity value, $Res Function(_$_MemberEntity) then) =
      __$$_MemberEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String assignedId});
}

/// @nodoc
class __$$_MemberEntityCopyWithImpl<$Res>
    extends _$MemberEntityCopyWithImpl<$Res, _$_MemberEntity>
    implements _$$_MemberEntityCopyWith<$Res> {
  __$$_MemberEntityCopyWithImpl(
      _$_MemberEntity _value, $Res Function(_$_MemberEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? assignedId = null,
  }) {
    return _then(_$_MemberEntity(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      assignedId: null == assignedId
          ? _value.assignedId
          : assignedId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MemberEntity extends _MemberEntity {
  const _$_MemberEntity({required this.userId, required this.assignedId})
      : super._();

  @override
  final String userId;
  @override
  final String assignedId;

  @override
  String toString() {
    return 'MemberEntity(userId: $userId, assignedId: $assignedId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MemberEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.assignedId, assignedId) ||
                other.assignedId == assignedId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, assignedId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MemberEntityCopyWith<_$_MemberEntity> get copyWith =>
      __$$_MemberEntityCopyWithImpl<_$_MemberEntity>(this, _$identity);
}

abstract class _MemberEntity extends MemberEntity {
  const factory _MemberEntity(
      {required final String userId,
      required final String assignedId}) = _$_MemberEntity;
  const _MemberEntity._() : super._();

  @override
  String get userId;
  @override
  String get assignedId;
  @override
  @JsonKey(ignore: true)
  _$$_MemberEntityCopyWith<_$_MemberEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
