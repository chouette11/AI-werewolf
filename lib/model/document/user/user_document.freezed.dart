// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDocument _$UserDocumentFromJson(Map<String, dynamic> json) {
  return _UserDocument.fromJson(json);
}

/// @nodoc
mixin _$UserDocument {
  @JsonKey(name: 'uid')
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDocumentCopyWith<UserDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDocumentCopyWith<$Res> {
  factory $UserDocumentCopyWith(
          UserDocument value, $Res Function(UserDocument) then) =
      _$UserDocumentCopyWithImpl<$Res, UserDocument>;
  @useResult
  $Res call({@JsonKey(name: 'uid') String uid});
}

/// @nodoc
class _$UserDocumentCopyWithImpl<$Res, $Val extends UserDocument>
    implements $UserDocumentCopyWith<$Res> {
  _$UserDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserDocumentCopyWith<$Res>
    implements $UserDocumentCopyWith<$Res> {
  factory _$$_UserDocumentCopyWith(
          _$_UserDocument value, $Res Function(_$_UserDocument) then) =
      __$$_UserDocumentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'uid') String uid});
}

/// @nodoc
class __$$_UserDocumentCopyWithImpl<$Res>
    extends _$UserDocumentCopyWithImpl<$Res, _$_UserDocument>
    implements _$$_UserDocumentCopyWith<$Res> {
  __$$_UserDocumentCopyWithImpl(
      _$_UserDocument _value, $Res Function(_$_UserDocument) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
  }) {
    return _then(_$_UserDocument(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserDocument extends _UserDocument {
  const _$_UserDocument({@JsonKey(name: 'uid') required this.uid}) : super._();

  factory _$_UserDocument.fromJson(Map<String, dynamic> json) =>
      _$$_UserDocumentFromJson(json);

  @override
  @JsonKey(name: 'uid')
  final String uid;

  @override
  String toString() {
    return 'UserDocument(uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserDocument &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserDocumentCopyWith<_$_UserDocument> get copyWith =>
      __$$_UserDocumentCopyWithImpl<_$_UserDocument>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDocumentToJson(
      this,
    );
  }
}

abstract class _UserDocument extends UserDocument {
  const factory _UserDocument(
      {@JsonKey(name: 'uid') required final String uid}) = _$_UserDocument;
  const _UserDocument._() : super._();

  factory _UserDocument.fromJson(Map<String, dynamic> json) =
      _$_UserDocument.fromJson;

  @override
  @JsonKey(name: 'uid')
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$_UserDocumentCopyWith<_$_UserDocument> get copyWith =>
      throw _privateConstructorUsedError;
}
