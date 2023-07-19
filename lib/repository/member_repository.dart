import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/firestore_data_source.dart';
import 'package:wordwolf/entity/member/member_entity.dart';
import 'package:wordwolf/repository/room_repository.dart';

final memberRepositoryProvider =
Provider<MemberRepository>((ref) => MemberRepository(ref));

class MemberRepository {
  MemberRepository(this.ref);

  final Ref ref;

  /// メンバーのストリームを取得
  Stream<MemberEntity> getMemberStream(String roomId) {
    final firestore = ref.read(firestoreProvider);
    return firestore
        .fetchMemberStream(roomId)
        .map((event) => MemberEntity.fromDoc(event));
  }

  /// ルームメンバーのストリームを取得
  Stream<List<MemberEntity>> getRoomMemberStream(String roomId) {
    final firestore = ref.read(firestoreProvider);
    return firestore.fetchMembersStream(roomId).map(
          (event) => event.map((e) => MemberEntity.fromDoc(e)).toList(),
    );
  }

  /// ルームが満員か判定
  Future<bool> isLimitMember(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final room = await ref.read(roomRepositoryProvider).getRoom(roomId);
    final maxNum = room.maxNum;
    final members = await firestore.fetchMembers(roomId);
    return maxNum == members.length;
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

  /// DBのmembersから生きているのを取得
  Future<List<MemberEntity>> getLivingMembersFromDB(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final mem = await firestore.fetchLivingMembers(roomId);
    return mem.map((e) => MemberEntity.fromDoc(e)).toList();
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

  /// メンバーを消滅
  Future<void> killMember(String roomId, String userId) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.killMember(roomId, userId);
  }

  /// 投票をリセット
  Future<void> resetVoted(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.resetVoted(roomId);
  }

  /// AIのランダムキル
  Future<void> randomKill(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final livingMembers = await getLivingMembersFromDB(roomId);
    int random = Random().nextInt(livingMembers.length);
    final killedMem = livingMembers[random];
    while (killedMem.userId == 'gpt') {
      random = Random().nextInt(livingMembers.length);
    }
    firestore.killMember(roomId, livingMembers[random].userId);
  }

}