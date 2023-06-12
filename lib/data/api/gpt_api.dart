import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:wordwolf/document/message/message_document.dart';

part 'gpt_api.g.dart';

final apiClientProvider = Provider((ref) => RestClient(Dio()));

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/messages")
  Future<List<MessageDocument>> getMessages();

  @POST("/message")
  Future<Message> fetchMessage(@Body() Topic topic);
}

@JsonSerializable()
class Message {
  String content;
  String userId;
  DateTime createdAt;

  Message({required this.content, required this.userId, required this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Topic {
  String title;

  Topic({required this.title});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}