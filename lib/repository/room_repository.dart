import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/firestore_data_source.dart';
import 'package:wordwolf/model/entity/member/member_entity.dart';
import 'package:wordwolf/model/entity/room/room_entity.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

final roomRepositoryProvider =
    Provider<RoomRepository>((ref) => RoomRepository(ref));

class RoomRepository {
  RoomRepository(this.ref);

  final Ref ref;

  /// 新規ルーム追加
  Future<void> makeRoom(String roomId, int maxNum) async {
    final firestore = ref.read(firestoreProvider);
    //gptの分を追加する
    final newMaxNum = maxNum + 1;
    final rng = Random();
    // 割り当てるidから0を取り除く
    final assignedId = rng.nextInt(newMaxNum) + 1;
    List<String> roles = ['人間', '人間', '電脳体'];
    switch (newMaxNum) {
      case 5:
        roles.add('電脳体');
      case 6:
        roles.add('村人');
        roles.add('狂人');
      case 7:
        roles.add('電脳体');
        roles.add('人間');
        roles.add('電脳体');
    }
    final topics = ['うどん', 'プログラミング', '雪', 'お祭り'];
    final topic = topics[rng.nextInt(topics.length)];
    final entity = RoomEntity(
      id: roomId,
      topic: topic,
      maxNum: newMaxNum,
      roles: roles,
      votedSum: 0,
      killedId: 404,
    );
    final roomDoc = entity.toRoomDocument();
    await firestore.createRoom(roomDoc);
    final memberEntity = MemberEntity(
      userId: 'gpt',
      assignedId: assignedId,
      role: '',
      isLive: true,
      voted: 0,
    );
    await firestore.addMemberToRoom(roomId, memberEntity.toMemberDocument());
  }

  /// ルームに参加
  Future<void> joinRoom(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final uid = ref.read(uidProvider);
    final entity = MemberEntity(
      userId: uid,
      assignedId: 0,
      role: '',
      isLive: true,
      voted: 0,
    );
    await firestore.addMemberToRoom(roomId, entity.toMemberDocument());
  }

  /// ルームのストリーム取得
  Stream<RoomEntity> getRoomStream(String roomId) {
    final firestore = ref.read(firestoreProvider);
    return firestore.fetchRoomStream(roomId).map(
          (event) => RoomEntity.fromDoc(event),
        );
  }

  ///　ルームが存在するか確認
  Future<bool> isRoom(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final rooms = await firestore.fetchRooms();
    final roomIds = rooms.map((e) => e.id).toList();
    return roomIds.contains(roomId);
  }

  Future<RoomEntity> getRoom(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final roomDoc = await firestore.fetchRoom(roomId);
    return RoomEntity.fromDoc(roomDoc);
  }

  /// キルメンバーのリセット
  Future<void> resetKilledId(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.updateKilledId(roomId, 404);
  }

  /// ルームから退出
  Future<void> leaveRoom(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final uid = ref.read(uidProvider);
    await firestore.deleteMember(roomId, uid);
    final members = await firestore.fetchMembers(roomId);
    if (members.isEmpty) {
      firestore.deleteRoom(roomId);
    }
  }
}
