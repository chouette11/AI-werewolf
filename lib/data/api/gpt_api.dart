import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:ai_werewolf/model/document/message/message_document.dart';

part 'gpt_api.g.dart';

final apiClientProvider = Provider((ref) => RestClient(Dio()));

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("https://asia-northeast1-wordwolf-1f53d.cloudfunctions.net/messages")
  Future<List<MessageDocument>> getMessages();

  @POST('https://us-central1-wordwolf-1f53d.cloudfunctions.net/checkOnlineRooms')
  Future<dynamic> checkOnlineRooms(@Body() UserReq user);

  @POST('https://asia-northeast1-wordwolf-1f53d.cloudfunctions.net/make_topic_answer_friend')
  Future<Message> fetchTopicAnswerMessage(@Body() Topic topic);

  @POST('https://asia-northeast1-wordwolf-1f53d.cloudfunctions.net/make_question_answer')
  Future<Message> fetchQuestionAnswerMessage(@Body() Message message);
}

@JsonSerializable()
class Message {
  String? topic;
  String content;
  String uid;

  Message({required this.topic, required this.content, required this.uid});

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

@JsonSerializable()
class UserReq {
  String uid;

  UserReq({required this.uid});

  factory UserReq.fromJson(Map<String, dynamic> json) => _$UserReqFromJson(json);
  Map<String, dynamic> toJson() => _$UserReqToJson(this);
}