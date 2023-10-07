import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/data/firestore_data_source.dart';
import 'package:ai_werewolf/model/entity/member/member_entity.dart';
import 'package:ai_werewolf/model/entity/room/room_entity.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:ai_werewolf/util/enum/role.dart';
import 'package:uuid/uuid.dart';

final roomRepositoryProvider =
    Provider<RoomRepository>((ref) => RoomRepository(ref));

class RoomRepository {
  RoomRepository(this.ref);

  final Ref ref;

  /// 新規ルーム追加
  Future<void> makeRoom(String roomId, int maxNum, {bool? isOnline}) async {
    final firestore = ref.read(firestoreProvider);
    //gptの分を追加する
    final newMaxNum = maxNum + 1;
    final rng = Random();
    // 割り当てるidから0を取り除く
    List<String> roles = [
      RoleEnum.human.displayName,
      RoleEnum.human.displayName,
      RoleEnum.humanoid.displayName,
    ];
    switch (newMaxNum) {
      case 5:
        roles.add(RoleEnum.humanoid.displayName);
      case 6:
        roles.add('村人');
        roles.add('狂人');
      case 7:
        roles.add(RoleEnum.humanoid.displayName);
        roles.add(RoleEnum.human.displayName);
        roles.add(RoleEnum.human.displayName);
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
      startTime: DateTime(2017, 9, 7, 17, 30),
    );

    if (isOnline == true) {
      await firestore.createOnlineRoom(entity.toRoomDocument());
    } else {
      await firestore.createRoom(entity.toRoomDocument());
    }

    final assignedId = rng.nextInt(newMaxNum) + 1;
    final memberEntity = MemberEntity(
      uid: 'gpt',
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
      uid: uid,
      assignedId: 0,
      role: '',
      isLive: true,
      voted: 0,
    );
    await firestore.addMemberToRoom(roomId, entity.toMemberDocument());
  }

  /// ルームが満員か判定
  Future<bool> isLimitRoom(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final room = await ref.read(roomRepositoryProvider).getRoom(roomId);
    final maxNum = room.maxNum;
    final members = await firestore.fetchMembers(roomId);
    return maxNum == members.length;
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
    await firestore.updateRoom(id: roomId, killedId: 404);
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

  /// オンラインルームを作成
  Future<String> makeOnlineRoom(int maxNum) async {
    final firestore = ref.read(firestoreProvider);
    final latestRoom = await firestore.fetchLatestOnlineRoom();
    if (latestRoom == null) {
      final roomId = const Uuid().v4();
      await makeRoom(roomId, maxNum, isOnline: true);
      return roomId;
    }
    final members = await firestore.fetchMembers(latestRoom.id);
    if (members.length == latestRoom.maxNum) {
      final roomId = const Uuid().v4();
      await makeRoom(roomId, maxNum, isOnline: true);
      return roomId;
    }
    return latestRoom.id;
  }
}
