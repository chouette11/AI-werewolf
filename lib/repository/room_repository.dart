import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/firestore_data_source.dart';
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
    final rng = Random();
    final memberId = rng.nextInt(maxNum);
    final entity =
        RoomEntity(id: roomId, members: {'gpt': memberId}, maxNum: maxNum);
    final roomDoc = entity.toRoomDocument();
    await firestore.createRoom(roomDoc);
  }

  /// ルームに参加
  Future<void> joinRoom(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final uid = ref.read(uidProvider);
    await firestore.addMemberToRoom(roomId, uid);
  }

  /// ルームメンバーのストリームを取得
  Stream<Map<String, int>> getRoomMemberStream(String roomId) {
    final firestore = ref.read(firestoreProvider);
    return firestore.fetchRoomStream(roomId).map(
          (event) => RoomEntity.fromDoc(event).members,
        );
  }
}
