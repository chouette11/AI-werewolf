import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_document.freezed.dart';

part 'user_document.g.dart';

@freezed
class UserDocument with _$UserDocument {
  const UserDocument._();

  const factory UserDocument({
    @JsonKey(name: 'uid') required String uid,
    @JsonKey(name: 'roomId') String? roomId,
  }) = _UserDocument;

  factory UserDocument.fromJson(Map<String, dynamic> json) =>
      _$UserDocumentFromJson(json);
}
