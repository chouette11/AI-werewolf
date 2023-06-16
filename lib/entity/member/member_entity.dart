import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordwolf/document/member/member_document.dart';

part 'member_entity.freezed.dart';

@freezed
class MemberEntity with _$MemberEntity {
  const MemberEntity._();

  const factory MemberEntity({
    required String userId,
    required String assignedId,
  }) = _MemberEntity;

  static MemberEntity fromDoc(MemberDocument memberDoc) {
    return MemberEntity(
      userId: memberDoc.userId,
      assignedId: memberDoc.assignedId.toString(),
    );
  }

  MemberDocument toMemberDocument() {
    return MemberDocument(
      userId: userId,
      assignedId: 0,
    );
  }
}
