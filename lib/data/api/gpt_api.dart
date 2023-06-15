import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:wordwolf/document/message/message_document.dart';

part 'gpt_api.g.dart';

final apiClientProvider = Provider((ref) => RestClient(Dio()));

@RestApi(baseUrl: "https://asia-northeast1-wordwolf-1f53d.cloudfunctions.net/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/messages")
  Future<List<MessageDocument>> getMessages();

  @POST('/make_topic_answer')
  Future<Message> fetchTopicAnswerMessage(@Body() Topic topic);

  @POST('/make_question_answer')
  Future<Message> fetchQuestionAnswerMessage(@Body() Message message);
}

@JsonSerializable()
class Message {
  String? topic;
  String content;
  String userId;

  Message({required this.topic, required this.content, required this.userId});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Topic {
  String topic;

  Topic({required this.topic});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}