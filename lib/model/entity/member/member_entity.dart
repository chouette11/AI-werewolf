import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ai_werewolf/model/document/member/member_document.dart';

part 'member_entity.freezed.dart';

@freezed
class MemberEntity with _$MemberEntity {
  const MemberEntity._();

  const factory MemberEntity({
    required String uid,
    required int assignedId,
    required String role,
    required bool isLive,
    required int voted,
  }) = _MemberEntity;

  static MemberEntity fromDoc(MemberDocument memberDoc) {
    return MemberEntity(
      uid: memberDoc.uid,
      assignedId: memberDoc.assignedId,
      role: memberDoc.role,
      isLive: memberDoc.isLive,
      voted: memberDoc.voted,
    );
  }

  MemberDocument toMemberDocument() {
    return MemberDocument(
      uid: uid,
      assignedId: assignedId,
      role: role,
      isLive: isLive,
      voted: voted,
    );
  }
}
