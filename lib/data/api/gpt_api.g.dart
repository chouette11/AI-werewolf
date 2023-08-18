// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpt_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      topic: json['topic'] as String?,
      content: json['content'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'topic': instance.topic,
      'content': instance.content,
      'userId': instance.userId,
    };

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      topic: json['topic'] as String,
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'topic': instance.topic,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://asia-northeast1-wordwolf-1f53d.cloudfunctions.net';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<MessageDocument>> getMessages() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<MessageDocument>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/messages',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => MessageDocument.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Message> fetchTopicAnswerMessage(Topic topic) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(topic.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Message>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/make_topic_answer_friend',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Message.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Message> fetchQuestionAnswerMessage(Message message) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(message.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Message>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/make_question_answer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Message.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
