import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/data/api_data_source.dart';
import 'package:ai_werewolf/data/firestore_data_source.dart';
import 'package:ai_werewolf/model/entity/message/message_entity.dart';
import 'package:ai_werewolf/provider/presentation_providers.dart';

final messageRepositoryProvider =
    Provider<MessageRepository>((ref) => MessageRepository(ref));

class MessageRepository {
  MessageRepository(this.ref);

  final Ref ref;

  /// 新規メッセージ追加
  Future<void> addMessage(String content, String roomId, String topic) async {
    final firestore = ref.read(firestoreProvider);
    final uid = ref.read(uidProvider);
    final entity =
        MessageEntity(content: content, uid: uid, createdAt: DateTime.now());
    final messageDoc = entity.toMessageDocument();
    await firestore.insertMessage(messageDoc, roomId);
    addMessageFromGptToQuestion(entity, roomId, topic);
  }

  /// 他のユーザーが疑問文で送ったときに対するAIの返答
  Future<void> addMessageFromGptToQuestion(
      MessageEntity message, String roomId, String topic) async {
    print('send_api');
    final api = ref.read(apiProvider);
    final firestore = ref.read(firestoreProvider);
    final resMessage = await api.fetchQuestionAnswerMessage(message, topic);
    final resEntity = MessageEntity(
      content: resMessage.content ?? '',
      uid: resMessage.uid,
      createdAt: DateTime.now(),
    );
    // 疑問文でない場合何も保存しない
    if (resEntity.content == '') {
      return;
    }
    final messageDoc = resEntity.toMessageDocument();
    await firestore.insertMessage(messageDoc, roomId);
  }

  /// タスクのストリームを取得
  Stream<List<MessageEntity>> getMessageStream(String roomId) {
    final firestore = ref.read(firestoreProvider);
    return firestore.fetchMessageStream(roomId).map(
          (event) => event.map((e) => MessageEntity.fromDoc(e)).toList(),
        );
  }

  /// すべてのメッセージを削除
  Future<void> deleteAllMessage(String roomId) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.deleteAllMessage(roomId);
  }
}
