import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/entity/message/message_entity.dart';
import 'package:wordwolf/provider/presentation_providers.dart';

class ReceiveMessageBubble extends ConsumerWidget {
  const ReceiveMessageBubble({
    Key? key,
    required this.messageEntity,
    required this.roomId,
  }) : super(key: key);
  final MessageEntity messageEntity;
  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersStreamProvider(roomId));
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          members.when(
            data: (data) {
              return Text(
                data[messageEntity.userId]!.toString(),
                style: const TextStyle(fontSize: 32),
              );
            },
            loading: () => const Text('loading'),
            error: (error, stackTrace) => Text(error.toString()),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorConstant.secondary,
                  spreadRadius: 0.1,
                  blurRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(24),
              color: ColorConstant.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(messageEntity.content),
            ),
          ),
        ],
      ),
    );
  }
}
