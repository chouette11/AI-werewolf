import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:wordwolf/document/message/message_document.dart';
import 'package:wordwolf/document/timestamp_converter.dart';

part 'gpt_api.g.dart';

final apiClientProvider = Provider((ref) => RestClient(Dio()));

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/messages")
  Future<List<MessageDocument>> getMessages();

  @POST("https://test-5uxbsy4xrq-an.a.run.app")
  Future<Message> fetchMessage(@Body() Topic topic);
}

@JsonSerializable()
class Message {
  String content;
  String userId;

  Message({required this.content, required this.userId});

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