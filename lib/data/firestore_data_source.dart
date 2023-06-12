import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/document/message/message_document.dart';
import 'package:wordwolf/document/room/room_document.dart';
import 'package:wordwolf/provider/domain_providers.dart';

final firestoreProvider =
    Provider<FirestoreDataSource>((ref) => FirestoreDataSource(ref: ref));

class FirestoreDataSource {
  FirestoreDataSource({required this.ref});

  final Ref ref;

  ///
  /// Message
  ///

  Stream<List<MessageDocument>> fetchMessageStream(String roomId) {
    try {
      final db = ref.read(firebaseFirestoreProvider);

      final stream = db
          .collection('rooms/$roomId/messages')
          .orderBy('createdAt', descending: true)
          .snapshots();
      return stream.map((event) => event.docs
          .map((doc) => doc.data())
          .map((data) => MessageDocument.fromJson(data))
          .toList());
    } catch (e) {
      print('firestore_getMessageStream');
      throw e;
    }
  }

  /// 新規メッセージ追加
  Future<void> insertMessage(
      MessageDocument messageDocument, String roomId) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms/$roomId/messages');
    await collection.add(messageDocument.copyWith.call().toJson());
  }

  /// Room

  /// 新規ルーム追加
  Future<void> createRoom(RoomDocument roomDocument) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms');
    await collection.add(roomDocument.copyWith.call().toJson());
  }
}
