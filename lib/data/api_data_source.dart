import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/data/api/gpt_api.dart';
import 'package:ai_werewolf/model/entity/message/message_entity.dart';

final apiProvider = Provider<ApiDataSource>((ref) => ApiDataSource(ref: ref));

class ApiDataSource {
  ApiDataSource({required this.ref});

  final Ref ref;

  ///
  /// Message
  ///

  Future<Message> fetchQuestionAnswerMessage(
    MessageEntity messageEntity,
    String topic,
  ) async {
    try {
      final api = ref.read(apiClientProvider);
      const flavor = String.fromEnvironment('flavor');
      final message = Message(
        topic: topic,
        content: messageEntity.content,
        uid: messageEntity.uid,
      );
      final resMessage = flavor == 'prod'
          ? await api.fetchQuestionAnswerMessage(message)
          : await api.fetchQuestionAnswerMessageDev(message);
      return resMessage;
    } catch (e) {
      print('api_getMessageWithPrompt');
      throw e;
    }
  }
}
