import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/firestore_data_source.dart';
import 'package:wordwolf/entity/task/message_entity.dart';

final messageRepositoryProvider =
    Provider<MessageRepository>((ref) => MessageRepository(ref));

class MessageRepository {
  MessageRepository(this.ref);

  final Ref ref;

  /// 新規タスク追加
  Future<void> addMessage(MessageEntity messageEntity, String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final messageDoc = await messageEntity.toMessageDocument();
    await firestore.insertMessage(messageDoc, roomId);
  }

  /// タスクのストリームを取得
  Stream<List<MessageEntity>> getMessageStream(String roomId) {
    final firestore = ref.read(firestoreProvider);
    return firestore.fetchMessageStream(roomId).map(
          (event) => event.map((e) => MessageEntity.fromDoc(e)).toList(),
        );
  }
}
