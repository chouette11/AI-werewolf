import 'package:ai_werewolf/data/firestore_data_source.dart';
import 'package:ai_werewolf/model/entity/user/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref));

class UserRepository {
  UserRepository(this.ref);

  final Ref ref;

  /// ウェイティングリストに追加
  Future<void> addWaiting(UserEntity user) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.addWaiting(user);
  }

  /// ウェイティングリストから削除
  Future<void> removeWaiting(UserEntity user) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.deleteWaiting(user.uid);
  }

  /// ウェイティングリストのストリーム取得
  Stream<UserEntity> getUserStream() {
    final firestore = ref.read(firestoreProvider);
    return firestore.fetchWaitingStream().map(
          (event) => UserEntity.fromDoc(event),
    );
  }
}
