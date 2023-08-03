// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomEntity _$RoomEntityFromJson(Map<String, dynamic> json) {
  return _RoomEntity.fromJson(json);
}

/// @nodoc
mixin _$RoomEntity {
  String get id => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  int get maxNum => throw _privateConstructorUsedError;
  List<String> get roles => throw _privateConstructorUsedError;
  int get votedSum => throw _privateConstructorUsedError;
  int get killedId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomEntityCopyWith<RoomEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomEntityCopyWith<$Res> {
  factory $RoomEntityCopyWith(
          RoomEntity value, $Res Function(RoomEntity) then) =
      _$RoomEntityCopyWithImpl<$Res, RoomEntity>;
  @useResult
  $Res call(
      {String id,
      String topic,
      int maxNum,
      List<String> roles,
      int votedSum,
      int killedId});
}

/// @nodoc
class _$RoomEntityCopyWithImpl<$Res, $Val extends RoomEntity>
    implements $RoomEntityCopyWith<$Res> {
  _$RoomEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? maxNum = null,
    Object? roles = null,
    Object? votedSum = null,
    Object? killedId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      maxNum: null == maxNum
          ? _value.maxNum
          : maxNum // ignore: cast_nullable_to_non_nullable
              as int,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      votedSum: null == votedSum
          ? _value.votedSum
          : votedSum // ignore: cast_nullable_to_non_nullable
              as int,
      killedId: null == killedId
          ? _value.killedId
          : killedId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoomEntityCopyWith<$Res>
    implements $RoomEntityCopyWith<$Res> {
  factory _$$_RoomEntityCopyWith(
          _$_RoomEntity value, $Res Function(_$_RoomEntity) then) =
      __$$_RoomEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String topic,
      int maxNum,
      List<String> roles,
      int votedSum,
      int killedId});
}

/// @nodoc
class __$$_RoomEntityCopyWithImpl<$Res>
    extends _$RoomEntityCopyWithImpl<$Res, _$_RoomEntity>
    implements _$$_RoomEntityCopyWith<$Res> {
  __$$_RoomEntityCopyWithImpl(
      _$_RoomEntity _value, $Res Function(_$_RoomEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? maxNum = null,
    Object? roles = null,
    Object? votedSum = null,
    Object? killedId = null,
  }) {
    return _then(_$_RoomEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      maxNum: null == maxNum
          ? _value.maxNum
          : maxNum // ignore: cast_nullable_to_non_nullable
              as int,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      votedSum: null == votedSum
          ? _value.votedSum
          : votedSum // ignore: cast_nullable_to_non_nullable
              as int,
      killedId: null == killedId
          ? _value.killedId
          : killedId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoomEntity extends _RoomEntity {
  const _$_RoomEntity(
      {required this.id,
      required this.topic,
      required this.maxNum,
      required final List<String> roles,
      required this.votedSum,
      required this.killedId})
      : _roles = roles,
        super._();

  factory _$_RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$$_RoomEntityFromJson(json);

  @override
  final String id;
  @override
  final String topic;
  @override
  final int maxNum;
  final List<String> _roles;
  @override
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final int votedSum;
  @override
  final int killedId;

  @override
  String toString() {
    return 'RoomEntity(id: $id, topic: $topic, maxNum: $maxNum, roles: $roles, votedSum: $votedSum, killedId: $killedId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.maxNum, maxNum) || other.maxNum == maxNum) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.votedSum, votedSum) ||
                other.votedSum == votedSum) &&
            (identical(other.killedId, killedId) ||
                other.killedId == killedId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, topic, maxNum,
      const DeepCollectionEquality().hash(_roles), votedSum, killedId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoomEntityCopyWith<_$_RoomEntity> get copyWith =>
      __$$_RoomEntityCopyWithImpl<_$_RoomEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoomEntityToJson(
      this,
    );
  }
}

abstract class _RoomEntity extends RoomEntity {
  const factory _RoomEntity(
      {required final String id,
      required final String topic,
      required final int maxNum,
      required final List<String> roles,
      required final int votedSum,
      required final int killedId}) = _$_RoomEntity;
  const _RoomEntity._() : super._();

  factory _RoomEntity.fromJson(Map<String, dynamic> json) =
      _$_RoomEntity.fromJson;

  @override
  String get id;
  @override
  String get topic;
  @override
  int get maxNum;
  @override
  List<String> get roles;
  @override
  int get votedSum;
  @override
  int get killedId;
  @override
  @JsonKey(ignore: true)
  _$$_RoomEntityCopyWith<_$_RoomEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
