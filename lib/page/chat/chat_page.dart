import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/constant/color_constant.dart';
import 'package:wordwolf/constant/text_style_constant.dart';
import 'package:wordwolf/page/chat/component/answer_dialog.dart';
import 'package:wordwolf/page/chat/component/bottom_text_field.dart';
import 'package:wordwolf/page/chat/component/receive_message_bubble.dart';
import 'package:wordwolf/page/chat/component/send_message_bubble.dart';
import 'package:wordwolf/provider/presentation_providers.dart';
import 'package:wordwolf/repository/message_repository.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.roomId});
  final String roomId;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final topic = "うどん";
  int _counter = 10;
  bool isDialog = false;

  @override
  void initState() {
    ref.read(messageRepositoryProvider).addMessageFromGpt(topic, widget.roomId);
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        _counter--;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesStreamProvider(widget.roomId));
    final uid = ref.watch(uidProvider);

    if (_counter == 0 && !isDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AnswerDialog(
          roomId: widget.roomId,
        ),
      );
      isDialog = true;
      });
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.main,
          centerTitle: true,
          title: Row(
            children: [
              Text("お題はうどん",
                  style: TextStyleConstant.bold16.copyWith(
                    color: ColorConstant.black100,
                  )),
              const Spacer(),
              Text('残り',
                  style: TextStyleConstant.normal12.copyWith(
                    color: ColorConstant.base,
                  )),
              Text(_counter >= 0 ? _counter.toString() : '0',
                  style: TextStyleConstant.bold16.copyWith(
                    color: ColorConstant.black100,
                  )),
              Text('秒',
                  style: TextStyleConstant.bold16.copyWith(
                    color: ColorConstant.black100,
                  )),
              const Spacer(),
              Text(
                'ID:',
                style: TextStyleConstant.normal12.copyWith(
                  color: ColorConstant.base,
                ),
              ),
              Text(
                widget.roomId,
                style: TextStyleConstant.normal14
                    .copyWith(color: ColorConstant.black100),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        bottomSheet: BottomTextField(roomId: widget.roomId),
        body: messages.when(
          data: (data) {
            return SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewInsets.bottom -
                  180,
              child: ListView.builder(
                reverse: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  data.sort((a, b) {
                    //sorting in descending order
                    return b.createdAt.compareTo(a.createdAt);
                  });
                  final message = data[index];
                  if (message.userId == uid) {
                    return SendMessageBubble(message: message.content);
                  } else {
                    return ReceiveMessageBubble(
                      messageEntity: message,
                      roomId: widget.roomId,
                    );
                  }
                },
              ),
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
