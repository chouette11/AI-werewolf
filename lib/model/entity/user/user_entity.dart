import 'package:ai_werewolf/model/document/user/user_document.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    required String uid,
    String? roomId,
  }) = _UserEntity;

  static UserEntity fromDoc(UserDocument userDoc) {
    return UserEntity(
      uid: userDoc.uid,
      roomId: userDoc.roomId
    );
  }

  UserDocument toUserDocument() {
    return UserDocument(
      uid: uid,
      roomId: roomId,
    );
  }
}
