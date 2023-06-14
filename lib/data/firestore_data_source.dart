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
    await collection.doc(roomDocument.id).set(roomDocument.copyWith.call().toJson());
  }

  /// ルームに参加
  Future<void> addMemberToRoom(String roomId, String userId) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms/$roomId/members');
    await collection.doc(userId).set({'userId': userId});
  }

  /// ルームを取得
  Future<RoomDocument> fetchRoom(String roomId) async {
    final db = ref.read(firebaseFirestoreProvider);
    final room = await db.collection('rooms').doc(roomId).get();
    return RoomDocument.fromJson(room.data()!);
  }

  /// ルームののストリームを取得
  Stream<RoomDocument> fetchRoomStream(String roomId) {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final stream = db.collection('rooms').doc(roomId).snapshots();
      return stream.map((event) => RoomDocument.fromJson(event.data()!));
    } catch (e) {
      print('firestore_getMemberStream');
      throw e;
    }
  }

  /// ルームの一覧を取得
  Future<List<RoomDocument>> fetchRooms() async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final rooms = await db.collection('rooms').get();
      return rooms.docs.map((e) => RoomDocument.fromJson(e.data())).toList();
    } catch (e) {
      print('firestore_getStream');
      throw e;
    }
  }

  /// ルームを削除
  Future<void> deleteRoom(String roomId) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      await db.collection('rooms').doc(roomId).delete();
    } catch (e) {
      print('delete_room');
      throw e;
    }
  }

  ///Member

  /// メンバーの取得
  Future<List<String>> fetchMembers(String roomId) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final members = await db.collection('rooms/$roomId/members').get();
      return members.docs.map((e) => e.id).toList();
    } catch (e) {
      print('fetch_members');
      throw e;
    }
  }

  /// メンバーの削除
  Future<void> deleteMember(String roomId, String uid) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      await db.collection('rooms/$roomId/members').doc(uid).delete();
    } catch (e) {
      print('delete_member');
      throw e;
    }
  }
}
