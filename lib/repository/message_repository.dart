import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/api_data_source.dart';
import 'package:wordwolf/data/firestore_data_source.dart';
import 'package:wordwolf/entity/message/message_entity.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

final messageRepositoryProvider =
    Provider<MessageRepository>((ref) => MessageRepository(ref));

class MessageRepository {
  MessageRepository(this.ref);

  final Ref ref;

  /// 新規タスク追加
  Future<void> addMessage(String content, String roomId) async {
    final firestore = ref.read(firestoreProvider);
    final uid = ref.read(uidProvider);
    final entity = MessageEntity(content: content, userId: uid, createdAt: DateTime.now());
    final messageDoc = entity.toMessageDocument();
    await firestore.insertMessage(messageDoc, roomId);
  }

  /// topicに対するAIの返答
  Future<void> addMessageFromGptToTopic(String topic, String roomId) async {
    final api = ref.read(apiProvider);
    final firestore = ref.read(firestoreProvider);
    final message = await api.fetchTopicAnswerMessage(topic);
    final entity = MessageEntity(content: message.content, userId: message.userId, createdAt: DateTime.now());
    final messageDoc = entity.toMessageDocument();
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
