import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/repository/message_repository.dart';

final exampleTextFieldProvider = StateProvider<String>((ref) => '');

final messagesStreamProvider = StreamProvider.family(
  (ref, String roomId) => ref.watch(messageRepositoryProvider).getMessageStream(roomId),
);

final answerRadioValueProvider = StateProvider<String>((ref) => '');
