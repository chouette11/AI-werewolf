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
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'maxNum')
  int get maxNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles')
  List<String> get roles => throw _privateConstructorUsedError;
  @JsonKey(name: 'votedSum')
  int get votedSum => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'maxNum') int maxNum,
      @JsonKey(name: 'roles') List<String> roles,
      @JsonKey(name: 'votedSum') int votedSum});
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
    Object? id = null,
    Object? maxNum = null,
    Object? roles = null,
    Object? votedSum = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'maxNum') int maxNum,
      @JsonKey(name: 'roles') List<String> roles,
      @JsonKey(name: 'votedSum') int votedSum});
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
    Object? id = null,
    Object? maxNum = null,
    Object? roles = null,
    Object? votedSum = null,
  }) {
    return _then(_$_RoomDocument(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoomDocument extends _RoomDocument {
  const _$_RoomDocument(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'maxNum') required this.maxNum,
      @JsonKey(name: 'roles') required final List<String> roles,
      @JsonKey(name: 'votedSum') required this.votedSum})
      : _roles = roles,
        super._();

  factory _$_RoomDocument.fromJson(Map<String, dynamic> json) =>
      _$$_RoomDocumentFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
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
  String toString() {
    return 'RoomDocument(id: $id, maxNum: $maxNum, roles: $roles, votedSum: $votedSum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomDocument &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.maxNum, maxNum) || other.maxNum == maxNum) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.votedSum, votedSum) ||
                other.votedSum == votedSum));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, maxNum,
      const DeepCollectionEquality().hash(_roles), votedSum);

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
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'maxNum') required final int maxNum,
          @JsonKey(name: 'roles') required final List<String> roles,
          @JsonKey(name: 'votedSum') required final int votedSum}) =
      _$_RoomDocument;
  const _RoomDocument._() : super._();

  factory _RoomDocument.fromJson(Map<String, dynamic> json) =
      _$_RoomDocument.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
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
  @JsonKey(ignore: true)
  _$$_RoomDocumentCopyWith<_$_RoomDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
