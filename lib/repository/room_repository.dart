import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/firestore_data_source.dart';
import 'package:wordwolf/entity/member/member_entity.dart';
import 'package:wordwolf/entity/room/room_entity.dart';
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
    final memberId = rng.nextInt(newMaxNum) + 1;
    List<String> roles = ['村人', '村人', '狂人'];
    switch (newMaxNum) {
      case 5:
        roles.add('村人');
      case 6:
        roles.add('村人');
        roles.add('狂人');
      case 7:
        roles.add('村人');
        roles.add('狂人');
        roles.add('村人');
    }
    final entity =
        RoomEntity(id: roomId, maxNum: newMaxNum, roles: roles, votedSum: 0);
    final roomDoc = entity.toRoomDocument();
    await firestore.createRoom(roomDoc);
    final memberEntity = MemberEntity(
      userId: 'gpt',
      assignedId: memberId.toString(),
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
      assignedId: '',
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

  /// ルームメンバーのストリームを取得
  Stream<List<MemberEntity>> getRoomMemberStream(String roomId) {
    final firestore = ref.read(firestoreProvider);
    return firestore.fetchMembersStream(roomId).map(
          (event) => event.map((e) => MemberEntity.fromDoc(e)).toList(),
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

  /// メンバーのストリームを取得
  Stream<MemberEntity> getMemberStream(String roomId) {
    final firestore = ref.read(firestoreProvider);
    return firestore
        .fetchMemberStream(roomId)
        .map((event) => MemberEntity.fromDoc(event));
  }

  /// メンバーを消滅
  Future<void> killMember(String roomId, String userId) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.killMember(roomId, userId);
  }

  /// 処刑するメンバー投票
  Future<void> voteForMember(String roomId, String assignedId) async {
    final firestore = ref.read(firestoreProvider);
    final members = await firestore.fetchMembers(roomId);
    final userId = members[
            members.indexWhere((e) => e.assignedId.toString() == assignedId)]
        .userId;
    await firestore.voteForMember(roomId, userId);
    await firestore.addVoteToRoom(roomId);
  }

  /// membersから生きているのを取得
  List<MemberEntity> getLivingMembers(List<MemberEntity> members) {
    final List<MemberEntity> liveMem = [];
    for (var member in members) {
      if (member.isLive == true) {
        liveMem.add(member);
      }
    }
    return liveMem;
  }

  /// AIのランダムキル
  void randomKill(String roomId, List<MemberEntity> members) {
    final firestore = ref.read(firestoreProvider);
    final livingMembers = getLivingMembers(members);
    int random = Random().nextInt(livingMembers.length);
    final killedMem = livingMembers[random];
    while (killedMem.userId == 'gpt') {
      random = Random().nextInt(livingMembers.length);
    }
    firestore.killMember(roomId, livingMembers[random].userId);
  }
}
