// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MemberDocument _$MemberDocumentFromJson(Map<String, dynamic> json) {
  return _MemberDocument.fromJson(json);
}

/// @nodoc
mixin _$MemberDocument {
  @JsonKey(name: 'uid')
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'assignedId')
  int get assignedId => throw _privateConstructorUsedError;
  @JsonKey(name: 'role')
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'isLive')
  bool get isLive => throw _privateConstructorUsedError;
  @JsonKey(name: 'voted')
  int get voted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemberDocumentCopyWith<MemberDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberDocumentCopyWith<$Res> {
  factory $MemberDocumentCopyWith(
          MemberDocument value, $Res Function(MemberDocument) then) =
      _$MemberDocumentCopyWithImpl<$Res, MemberDocument>;
  @useResult
  $Res call(
      {@JsonKey(name: 'uid') String uid,
      @JsonKey(name: 'assignedId') int assignedId,
      @JsonKey(name: 'role') String role,
      @JsonKey(name: 'isLive') bool isLive,
      @JsonKey(name: 'voted') int voted});
}

/// @nodoc
class _$MemberDocumentCopyWithImpl<$Res, $Val extends MemberDocument>
    implements $MemberDocumentCopyWith<$Res> {
  _$MemberDocumentCopyWithImpl(this._value, this._then);

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
abstract class _$$_MemberDocumentCopyWith<$Res>
    implements $MemberDocumentCopyWith<$Res> {
  factory _$$_MemberDocumentCopyWith(
          _$_MemberDocument value, $Res Function(_$_MemberDocument) then) =
      __$$_MemberDocumentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'uid') String uid,
      @JsonKey(name: 'assignedId') int assignedId,
      @JsonKey(name: 'role') String role,
      @JsonKey(name: 'isLive') bool isLive,
      @JsonKey(name: 'voted') int voted});
}

/// @nodoc
class __$$_MemberDocumentCopyWithImpl<$Res>
    extends _$MemberDocumentCopyWithImpl<$Res, _$_MemberDocument>
    implements _$$_MemberDocumentCopyWith<$Res> {
  __$$_MemberDocumentCopyWithImpl(
      _$_MemberDocument _value, $Res Function(_$_MemberDocument) _then)
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
    return _then(_$_MemberDocument(
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
@JsonSerializable()
class _$_MemberDocument extends _MemberDocument {
  const _$_MemberDocument(
      {@JsonKey(name: 'uid') required this.uid,
      @JsonKey(name: 'assignedId') required this.assignedId,
      @JsonKey(name: 'role') required this.role,
      @JsonKey(name: 'isLive') required this.isLive,
      @JsonKey(name: 'voted') required this.voted})
      : super._();

  factory _$_MemberDocument.fromJson(Map<String, dynamic> json) =>
      _$$_MemberDocumentFromJson(json);

  @override
  @JsonKey(name: 'uid')
  final String uid;
  @override
  @JsonKey(name: 'assignedId')
  final int assignedId;
  @override
  @JsonKey(name: 'role')
  final String role;
  @override
  @JsonKey(name: 'isLive')
  final bool isLive;
  @override
  @JsonKey(name: 'voted')
  final int voted;

  @override
  String toString() {
    return 'MemberDocument(uid: $uid, assignedId: $assignedId, role: $role, isLive: $isLive, voted: $voted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MemberDocument &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.assignedId, assignedId) ||
                other.assignedId == assignedId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.voted, voted) || other.voted == voted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, assignedId, role, isLive, voted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MemberDocumentCopyWith<_$_MemberDocument> get copyWith =>
      __$$_MemberDocumentCopyWithImpl<_$_MemberDocument>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MemberDocumentToJson(
      this,
    );
  }
}

abstract class _MemberDocument extends MemberDocument {
  const factory _MemberDocument(
      {@JsonKey(name: 'uid') required final String uid,
      @JsonKey(name: 'assignedId') required final int assignedId,
      @JsonKey(name: 'role') required final String role,
      @JsonKey(name: 'isLive') required final bool isLive,
      @JsonKey(name: 'voted') required final int voted}) = _$_MemberDocument;
  const _MemberDocument._() : super._();

  factory _MemberDocument.fromJson(Map<String, dynamic> json) =
      _$_MemberDocument.fromJson;

  @override
  @JsonKey(name: 'uid')
  String get uid;
  @override
  @JsonKey(name: 'assignedId')
  int get assignedId;
  @override
  @JsonKey(name: 'role')
  String get role;
  @override
  @JsonKey(name: 'isLive')
  bool get isLive;
  @override
  @JsonKey(name: 'voted')
  int get voted;
  @override
  @JsonKey(ignore: true)
  _$$_MemberDocumentCopyWith<_$_MemberDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
