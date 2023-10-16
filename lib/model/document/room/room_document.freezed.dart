// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomDocument _$RoomDocumentFromJson(Map<String, dynamic> json) {
  return _RoomDocument.fromJson(json);
}

/// @nodoc
mixin _$RoomDocument {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic')
  String get topic => throw _privateConstructorUsedError;
  @JsonKey(name: 'maxNum')
  int get maxNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles')
  List<String> get roles => throw _privateConstructorUsedError;
  @JsonKey(name: 'votedSum')
  int get votedSum => throw _privateConstructorUsedError;
  @JsonKey(name: 'killedId')
  int get killedId => throw _privateConstructorUsedError;
  @TimestampConverter()
  @JsonKey(name: 'startTime')
  DateTime get startTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomDocumentCopyWith<RoomDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomDocumentCopyWith<$Res> {
  factory $RoomDocumentCopyWith(
          RoomDocument value, $Res Function(RoomDocument) then) =
      _$RoomDocumentCopyWithImpl<$Res, RoomDocument>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'topic') String topic,
      @JsonKey(name: 'maxNum') int maxNum,
      @JsonKey(name: 'roles') List<String> roles,
      @JsonKey(name: 'votedSum') int votedSum,
      @JsonKey(name: 'killedId') int killedId,
      @TimestampConverter() @JsonKey(name: 'startTime') DateTime startTime,
      @TimestampConverter() @JsonKey(name: 'createdAt') DateTime? createdAt});
}

/// @nodoc
class _$RoomDocumentCopyWithImpl<$Res, $Val extends RoomDocument>
    implements $RoomDocumentCopyWith<$Res> {
  _$RoomDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? topic = null,
    Object? maxNum = null,
    Object? roles = null,
    Object? votedSum = null,
    Object? killedId = null,
    Object? startTime = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoomDocumentCopyWith<$Res>
    implements $RoomDocumentCopyWith<$Res> {
  factory _$$_RoomDocumentCopyWith(
          _$_RoomDocument value, $Res Function(_$_RoomDocument) then) =
      __$$_RoomDocumentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'topic') String topic,
      @JsonKey(name: 'maxNum') int maxNum,
      @JsonKey(name: 'roles') List<String> roles,
      @JsonKey(name: 'votedSum') int votedSum,
      @JsonKey(name: 'killedId') int killedId,
      @TimestampConverter() @JsonKey(name: 'startTime') DateTime startTime,
      @TimestampConverter() @JsonKey(name: 'createdAt') DateTime? createdAt});
}

/// @nodoc
class __$$_RoomDocumentCopyWithImpl<$Res>
    extends _$RoomDocumentCopyWithImpl<$Res, _$_RoomDocument>
    implements _$$_RoomDocumentCopyWith<$Res> {
  __$$_RoomDocumentCopyWithImpl(
      _$_RoomDocument _value, $Res Function(_$_RoomDocument) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? topic = null,
    Object? maxNum = null,
    Object? roles = null,
    Object? votedSum = null,
    Object? killedId = null,
    Object? startTime = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$_RoomDocument(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoomDocument extends _RoomDocument {
  const _$_RoomDocument(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'topic') required this.topic,
      @JsonKey(name: 'maxNum') required this.maxNum,
      @JsonKey(name: 'roles') required final List<String> roles,
      @JsonKey(name: 'votedSum') required this.votedSum,
      @JsonKey(name: 'killedId') required this.killedId,
      @TimestampConverter() @JsonKey(name: 'startTime') required this.startTime,
      @TimestampConverter() @JsonKey(name: 'createdAt') this.createdAt})
      : _roles = roles,
        super._();

  factory _$_RoomDocument.fromJson(Map<String, dynamic> json) =>
      _$$_RoomDocumentFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'topic')
  final String topic;
  @override
  @JsonKey(name: 'maxNum')
  final int maxNum;
  final List<String> _roles;
  @override
  @JsonKey(name: 'roles')
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  @JsonKey(name: 'votedSum')
  final int votedSum;
  @override
  @JsonKey(name: 'killedId')
  final int killedId;
  @override
  @TimestampConverter()
  @JsonKey(name: 'startTime')
  final DateTime startTime;
  @override
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'RoomDocument(id: $id, topic: $topic, maxNum: $maxNum, roles: $roles, votedSum: $votedSum, killedId: $killedId, startTime: $startTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomDocument &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.maxNum, maxNum) || other.maxNum == maxNum) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.votedSum, votedSum) ||
                other.votedSum == votedSum) &&
            (identical(other.killedId, killedId) ||
                other.killedId == killedId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      topic,
      maxNum,
      const DeepCollectionEquality().hash(_roles),
      votedSum,
      killedId,
      startTime,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoomDocumentCopyWith<_$_RoomDocument> get copyWith =>
      __$$_RoomDocumentCopyWithImpl<_$_RoomDocument>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoomDocumentToJson(
      this,
    );
  }
}

abstract class _RoomDocument extends RoomDocument {
  const factory _RoomDocument(
      {@JsonKey(name: 'id')
          final String? id,
      @JsonKey(name: 'topic')
          required final String topic,
      @JsonKey(name: 'maxNum')
          required final int maxNum,
      @JsonKey(name: 'roles')
          required final List<String> roles,
      @JsonKey(name: 'votedSum')
          required final int votedSum,
      @JsonKey(name: 'killedId')
          required final int killedId,
      @TimestampConverter()
      @JsonKey(name: 'startTime')
          required final DateTime startTime,
      @TimestampConverter()
      @JsonKey(name: 'createdAt')
          final DateTime? createdAt}) = _$_RoomDocument;
  const _RoomDocument._() : super._();

  factory _RoomDocument.fromJson(Map<String, dynamic> json) =
      _$_RoomDocument.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'topic')
  String get topic;
  @override
  @JsonKey(name: 'maxNum')
  int get maxNum;
  @override
  @JsonKey(name: 'roles')
  List<String> get roles;
  @override
  @JsonKey(name: 'votedSum')
  int get votedSum;
  @override
  @JsonKey(name: 'killedId')
  int get killedId;
  @override
  @TimestampConverter()
  @JsonKey(name: 'startTime')
  DateTime get startTime;
  @override
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_RoomDocumentCopyWith<_$_RoomDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
