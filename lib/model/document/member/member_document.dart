import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_document.freezed.dart';

part 'member_document.g.dart';

@freezed
class MemberDocument with _$MemberDocument {
  const MemberDocument._();

  const factory MemberDocument({
    @JsonKey(name: 'uid') required String uid,
    @JsonKey(name: 'assignedId') required int assignedId,
    @JsonKey(name: 'role') required String role,
    @JsonKey(name: 'isLive') required bool isLive,
    @JsonKey(name: 'voted') required int voted,
  }) = _MemberDocument;

  factory MemberDocument.fromJson(Map<String, dynamic> json) =>
      _$MemberDocumentFromJson(json);
}
