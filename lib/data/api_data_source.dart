import 'package:ai_werewolf/provider/presentation_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/data/api/gpt_api.dart';
import 'package:ai_werewolf/model/entity/message/message_entity.dart';

final apiProvider = Provider<ApiDataSource>((ref) => ApiDataSource(ref: ref));

class ApiDataSource {
  ApiDataSource({required this.ref});

  final Ref ref;

  ///
  /// Room
  ///

  /// オンラインのルームをチェック

  Future<dynamic> checkOnlineRooms() async {
    try {
      final api = ref.read(apiClientProvider);
      final uid = ref.read(uidProvider);
      final message = await api.checkOnlineRooms(UserReq(uid: uid));
      print(message);
      return message;
    } catch (e) {
      print('api_checkOnline');
      throw e;
    }
  }

  ///
  /// Message
  ///

  Future<Message> fetchTopicAnswerMessage(String topic) async {
    try {
      final api = ref.read(apiClientProvider);
      final message = await api.fetchTopicAnswerMessage(Topic(topic: topic));
      return message;
    } catch (e) {
      print('api_getMessageWithPrompt');
      throw e;
    }
  }

  Future<Message> fetchQuestionAnswerMessage(
    MessageEntity message,
    String topic,
  ) async {
    try {
      final api = ref.read(apiClientProvider);
      final resMessage = await api.fetchQuestionAnswerMessage(
        Message(
          topic: topic,
          content: message.content,
          uid: message.uid,
        ),
      );
      print(resMessage.content);
      return resMessage;
    } catch (e) {
      print('api_getMessageWithPrompt');
      throw e;
    }
  }
}
