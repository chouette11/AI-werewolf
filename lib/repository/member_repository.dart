import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/data/firestore_data_source.dart';
import 'package:ai_werewolf/model/entity/member/member_entity.dart';
import 'package:ai_werewolf/repository/room_repository.dart';

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
  Future<void> voteForMember(String roomId, int assignedId) async {
    final firestore = ref.read(firestoreProvider);
    final members = await firestore.fetchMembers(roomId);
    final uid =
        members[members.indexWhere((e) => e.assignedId == assignedId)].uid;
    await firestore.voteForMember(roomId, uid);
    await firestore.addVoteToRoom(roomId);
  }

  /// メンバーを消滅
  Future<void> killMember(String roomId, String uid) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.killMember(roomId, uid);
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
    livingMembers.removeWhere((e) => e.uid == 'gpt');
    int random = Random().nextInt(livingMembers.length - 1);
    await firestore.killMember(roomId, livingMembers[random].uid);
    await firestore.updateRoom(
        id: roomId, killedId: livingMembers[random].assignedId);
  }
}
