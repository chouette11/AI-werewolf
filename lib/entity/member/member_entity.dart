import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordwolf/document/member/member_document.dart';

part 'member_entity.freezed.dart';

@freezed
class MemberEntity with _$MemberEntity {
  const MemberEntity._();

  const factory MemberEntity({
    required String userId,
    required String assignedId,
    required String role,
    required bool isLive,
    required int voted,
  }) = _MemberEntity;

  static MemberEntity fromDoc(MemberDocument memberDoc) {
    return MemberEntity(
      userId: memberDoc.userId,
      assignedId: memberDoc.assignedId.toString(),
      role: memberDoc.role,
      isLive: memberDoc.isLive,
      voted: memberDoc.voted,
    );
  }

  MemberDocument toMemberDocument() {
    return MemberDocument(
      userId: userId,
      assignedId: assignedId == '' ? 0 : int.parse(assignedId),
      role: role,
      isLive: isLive,
      voted: voted,
    );
  }
}
