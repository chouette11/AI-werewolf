import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/data/api/gpt_api.dart';

final apiProvider = Provider<ApiDataSource>((ref) => ApiDataSource(ref: ref));

class ApiDataSource {
  ApiDataSource({required this.ref});

  final Ref ref;

  ///
  /// Message
  ///

  Future<Message> fetchMessage(String topic) async {
    try {
      final api = ref.read(apiClientProvider);
      final message = await api.fetchMessage(Topic(topic: topic));
      return message;
    } catch (e) {
      print('api_getMessage');
      throw e;
    }
  }
}
