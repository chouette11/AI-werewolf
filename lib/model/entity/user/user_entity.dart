import 'package:ai_werewolf/model/document/user/user_document.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    required String uid,
  }) = _UserEntity;

  static UserEntity fromDoc(UserDocument memberDoc) {
    return UserEntity(
      uid: memberDoc.uid,
    );
  }

  UserDocument toUserDocument() {
    return UserDocument(
      uid: uid,
    );
  }
}
