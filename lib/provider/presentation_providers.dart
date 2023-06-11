import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/repository/task_repository.dart';

final exampleTextFieldProvider = StateProvider<String>((ref) => '');

final messagesStreamProvider = StreamProvider(
  (ref) => ref.watch(messageRepositoryProvider).getMessageStream("0000"),
);
