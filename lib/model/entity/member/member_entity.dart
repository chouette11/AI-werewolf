import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ai_werewolf/model/document/member/member_document.dart';

part 'member_entity.freezed.dart';

@freezed
class MemberEntity with _$MemberEntity {
  const MemberEntity._();

  const factory MemberEntity({
    required String userId,
    required int assignedId,
    required String role,
    required bool isLive,
    required int voted,
  }) = _MemberEntity;

  static MemberEntity fromDoc(MemberDocument memberDoc) {
    return MemberEntity(
      userId: memberDoc.userId,
      assignedId: memberDoc.assignedId,
      role: memberDoc.role,
      isLive: memberDoc.isLive,
      voted: memberDoc.voted,
    );
  }

  MemberDocument toMemberDocument() {
    return MemberDocument(
      userId: userId,
      assignedId: assignedId,
      role: role,
      isLive: isLive,
      voted: voted,
    );
  }
}
