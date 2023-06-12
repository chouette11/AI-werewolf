import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/api/gpt_api.dart';
import 'package:wordwolf/document/message/message_document.dart';

final apiProvider =
    Provider<ApiDataSource>((ref) => ApiDataSource(ref: ref));

class ApiDataSource {
  ApiDataSource({required this.ref});

  final Ref ref;

  ///
  /// Message
  ///

  Future<MessageDocument> fetchMessage(String topic) async {
    try {
      final api = ref.read(apiClientProvider);
      final message = await api.fetchMessage(Topic(title: topic));
      return MessageDocument.fromJson(message.toJson());
    } catch (e) {
      print('api_getMessage');
      throw e;
    }
  }
}
