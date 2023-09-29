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
  String get uid => throw _privateConstructorUsedError;
  int get assignedId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  bool get isLive => throw _privateConstructorUsedError;
  int get voted => throw _privateConstructorUsedError;

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
  $Res call({String uid, int assignedId, String role, bool isLive, int voted});
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
    Object? uid = null,
    Object? assignedId = null,
    Object? role = null,
    Object? isLive = null,
    Object? voted = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      assignedId: null == assignedId
          ? _value.assignedId
          : assignedId // ignore: cast_nullable_to_non_nullable
              as int,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      isLive: null == isLive
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool,
      voted: null == voted
          ? _value.voted
          : voted // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({String uid, int assignedId, String role, bool isLive, int voted});
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
    Object? uid = null,
    Object? assignedId = null,
    Object? role = null,
    Object? isLive = null,
    Object? voted = null,
  }) {
    return _then(_$_MemberEntity(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      assignedId: null == assignedId
          ? _value.assignedId
          : assignedId // ignore: cast_nullable_to_non_nullable
              as int,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      isLive: null == isLive
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool,
      voted: null == voted
          ? _value.voted
          : voted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_MemberEntity extends _MemberEntity {
  const _$_MemberEntity(
      {required this.uid,
      required this.assignedId,
      required this.role,
      required this.isLive,
      required this.voted})
      : super._();

  @override
  final String uid;
  @override
  final int assignedId;
  @override
  final String role;
  @override
  final bool isLive;
  @override
  final int voted;

  @override
  String toString() {
    return 'MemberEntity(uid: $uid, assignedId: $assignedId, role: $role, isLive: $isLive, voted: $voted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MemberEntity &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.assignedId, assignedId) ||
                other.assignedId == assignedId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.voted, voted) || other.voted == voted));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, assignedId, role, isLive, voted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MemberEntityCopyWith<_$_MemberEntity> get copyWith =>
      __$$_MemberEntityCopyWithImpl<_$_MemberEntity>(this, _$identity);
}

abstract class _MemberEntity extends MemberEntity {
  const factory _MemberEntity(
      {required final String uid,
      required final int assignedId,
      required final String role,
      required final bool isLive,
      required final int voted}) = _$_MemberEntity;
  const _MemberEntity._() : super._();

  @override
  String get uid;
  @override
  int get assignedId;
  @override
  String get role;
  @override
  bool get isLive;
  @override
  int get voted;
  @override
  @JsonKey(ignore: true)
  _$$_MemberEntityCopyWith<_$_MemberEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
