import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/model/document/member/member_document.dart';
import 'package:ai_werewolf/model/document/message/message_document.dart';
import 'package:ai_werewolf/model/document/room/room_document.dart';

import 'package:ai_werewolf/provider/domain_providers.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';

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

  /// メッセージをすべて削除
  Future<void> deleteAllMessage(String roomId) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms/$roomId/messages');
    await collection.get().asStream().forEach((element) {
      for (var element in element.docs) {
        element.reference.delete();
      }
    });
  }

  /// Room

  /// 新規ルーム追加
  Future<void> createRoom(RoomDocument roomDocument) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms');
    await collection
        .doc(roomDocument.id)
        .set(roomDocument.copyWith.call().toJson());
  }

  /// 新規オンラインルーム追加
  Future<void> createOnlineRoom(RoomDocument roomDocument) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms');
    await collection
        .doc(roomDocument.id)
        .set(roomDocument.copyWith(createdAt: DateTime.now()).toJson());
  }

  /// ルームを取得
  Future<RoomDocument> fetchRoom(String roomId) async {
    final db = ref.read(firebaseFirestoreProvider);
    final room = await db.collection('rooms').doc(roomId).get();
    return RoomDocument.fromJson(room.data()!);
  }

  /// 最新のオンラインルームを取得
  Future<RoomDocument?> fetchLatestOnlineRoom() async {
    final db = ref.read(firebaseFirestoreProvider);
    final room = await db
        .collection('rooms')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (room.size == 0) {
      return null;
    }
    return RoomDocument.fromJson(room.docs.first.data());
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

  /// ルームの更新
  Future<void> updateRoom({
    required String id,
    String? topic,
    int? maxNum,
    List<String>? roles,
    int? votedSum,
    int? killedId,
    DateTime? startTime,
  }) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final docRef = db.collection('rooms').doc(id);
      await db.runTransaction((Transaction transaction) async {
        // トランザクション内でドキュメントを読み込む
        final snapshot = await transaction.get(docRef);
        final room = RoomDocument.fromJson(snapshot.data()!);

        // ドキュメントを更新する
        transaction.update(
            docRef,
            room.copyWith
                .call(
                  topic: topic ?? room.topic,
                  maxNum: maxNum ?? room.maxNum,
                  roles: roles ?? room.roles,
                  votedSum: votedSum ?? room.votedSum,
                  killedId: killedId ?? room.killedId,
                  startTime: startTime ?? room.startTime,
                )
                .toJson());
      });
    } catch (e) {
      print('update_room');
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

  /// ルームに参加
  Future<void> addMemberToRoom(String roomId, MemberDocument member) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms/$roomId/members');
    await collection.doc(member.uid).set(member.copyWith.call().toJson());
  }

  /// メンバーのストリームを取得
  Stream<List<MemberDocument>> fetchMembersStream(String roomId) {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final stream = db.collection('rooms/$roomId/members').snapshots();
      return stream.map((event) => event.docs
          .map((doc) => doc.data())
          .map((data) => MemberDocument.fromJson(data))
          .toList());
    } catch (e) {
      print('firestore_getMemberStream');
      throw e;
    }
  }

  /// メンバーの取得
  Future<List<MemberDocument>> fetchMembers(String roomId) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final members = await db.collection('rooms/$roomId/members').get();
      return members.docs
          .map((e) => MemberDocument.fromJson(e.data()))
          .toList();
    } catch (e) {
      print('fetch_members');
      throw e;
    }
  }

  /// メンバーのストリームを取得
  Stream<MemberDocument> fetchMemberStream(String roomId) {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final uid = ref.read(uidProvider);
      final stream =
          db.collection('rooms/$roomId/members').doc(uid).snapshots();
      return stream.map((event) => MemberDocument.fromJson(event.data()!));
    } catch (e) {
      print('firestore_getMemberStream');
      throw e;
    }
  }

  /// 生きているメンバーの取得
  Future<List<MemberDocument>> fetchLivingMembers(String roomId) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final members = await db
          .collection('rooms/$roomId/members')
          .where('isLive', isEqualTo: true)
          .get();
      return members.docs
          .map((e) => MemberDocument.fromJson(e.data()))
          .toList();
    } catch (e) {
      print('fetch_members');
      throw e;
    }
  }

  /// メンバーの消滅
  Future<void> killMember(String roomId, String uid) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      await db
          .collection('rooms/$roomId/members')
          .doc(uid)
          .update({'isLive': false});
    } catch (e) {
      print('kill_member');
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

  /// Vote

  /// 投票する
  Future<void> voteForMember(String roomId, String uid) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      await db
          .collection('rooms/$roomId/members')
          .doc(uid)
          .update({'voted': FieldValue.increment(1)});
    } catch (e) {
      print('vote_for_member');
      throw e;
    }
  }

  /// 投票をカウントする
  Future<void> addVoteToRoom(String roomId) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      await db.collection('rooms').doc(roomId).update(
        {'votedSum': FieldValue.increment(1)},
      );
    } catch (e) {
      print('count_vote');
      throw e;
    }
  }

  /// 投票をリセットする
  Future<void> resetVoted(String roomId) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      await db.collection('rooms').doc(roomId).update(
        {'votedSum': 0},
      );
      final collection = db.collection('rooms/$roomId/messages');
      await collection.get().asStream().forEach((element) {
        for (var element in element.docs) {
          element.reference.update({'voted': 0});
        }
      });
    } catch (e) {}
  }
}
