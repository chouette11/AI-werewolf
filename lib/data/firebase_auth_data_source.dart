import 'package:ai_werewolf/provider/domain_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
Provider<FirebaseAuthDataSource>((ref) => FirebaseAuthDataSource(ref: ref));

class FirebaseAuthDataSource {
  FirebaseAuthDataSource({required this.ref});

  final Ref ref;

  /// 自動ログイン
  Future<void> autoLogin() async {
    final auth = ref.read(firebaseAuthProvider);
    final user = auth.currentUser;
    if (user == null || user.email == null) {
      await auth.signInAnonymously();
    }
  }
}