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
  $Res call({String id});
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
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({String id});
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
  }) {
    return _then(_$_RoomEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoomEntity extends _RoomEntity {
  const _$_RoomEntity({required this.id}) : super._();

  factory _$_RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$$_RoomEntityFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'RoomEntity(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomEntity &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

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
  const factory _RoomEntity({required final String id}) = _$_RoomEntity;
  const _RoomEntity._() : super._();

  factory _RoomEntity.fromJson(Map<String, dynamic> json) =
      _$_RoomEntity.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_RoomEntityCopyWith<_$_RoomEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
