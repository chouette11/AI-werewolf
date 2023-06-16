import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_document.freezed.dart';

part 'member_document.g.dart';

@freezed
class MemberDocument with _$MemberDocument {
  const MemberDocument._();

  const factory MemberDocument({
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'assignedId') required int assignedId,
  }) = _MemberDocument;

  factory MemberDocument.fromJson(Map<String, dynamic> json) =>
      _$MemberDocumentFromJson(json);
}