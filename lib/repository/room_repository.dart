import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/firestore_data_source.dart';
import 'package:wordwolf/entity/room/room_entity.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

final roomRepositoryProvider =
    Provider<RoomRepository>((ref) => RoomRepository(ref));

class RoomRepository {
  RoomRepository(this.ref);

  final Ref ref;

  /// 新規タスク追加
  Future<void> makeRoom(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final entity = RoomEntity(id: roomId);
    final roomDoc = entity.toRoomDocument();
    await firestore.createRoom(roomDoc);
  }

  Future<void> joinRoom(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final uid = ref.read(uidProvider);
    await firestore.addMemberToRoom(roomId, uid);
  }
}
