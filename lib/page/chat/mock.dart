// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_template/constants/color_constant.dart';
// import 'package:flutter_template/entity/chat/chat_entity.dart';
// import 'package:flutter_template/pages/message/children/receive_message_bubble.dart';
// import 'package:flutter_template/pages/message/children/send_message_bubble.dart';
// import 'package:flutter_template/providers/domain_providers.dart';
// import 'package:flutter_template/providers/infrastructure_providers.dart';
// import 'package:flutter_template/providers/presentation_providers.dart';
// import 'package:flutter_template/repositories/chat_repository.dart';

// class TalkPage extends ConsumerWidget {
//   const TalkPage({Key? key, required this.oppToken}) : super(key: key);
//   final String oppToken;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final myOpp = ref.watch(chatMyOppStreamProvider(oppToken));
//     final oppMy = ref.watch(chatOppMyStreamProvider(oppToken));
//     print("ああi");
//     return Scaffold(
//       backgroundColor: ColorConstant.black100,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: ColorConstant.black100,
//         foregroundColor: ColorConstant.green40,
//         title: Text('aaa'),
//       ),
//       body: SafeArea(
//         child: Container(
//           color: ColorConstant.black100,
//           padding: EdgeInsets.all(8),
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height - 160,
//           child: myOpp.when(
//             data: (myOpp) {
//               return oppMy.when(
//                 data: (oppMy) {
//                   return ListView.builder(
//                     reverse: true,
//                     itemCount: myOpp.length + oppMy.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final messages = [...myOpp, ...oppMy];
//                       messages.sort((a, b){ //sorting in descending order
//                         return b.updateAt.compareTo(a.updateAt);
//                       });
//                       final message = messages[index];
//                       if (message.myToken != oppToken){
//                         return SendMessageBubble(message: message.message);
//                       }
//                       else {
//                         return ReceiveMessageBubble(message: message.message);
//                       }
//                     },
//                   );
//                 },
//                 error: (error, stackTrace) {
//                   return Text(error.toString());
//                 },
//                 loading: () {
//                   return Column(
//                     children: [
//                       Text('loading...'),
//                     ],
//                   );
//                 },
//               );
//             },
//             error: (error, stackTrace) {
//               return Text(error.toString());
//             },
//             loading: () {
//               return Column(
//                 children: [
//                   Text('loading...'),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//       bottomSheet: Container(
//         padding: EdgeInsets.all(8),
//         height: 64,
//         child: Align(
//           alignment: Alignment.center,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: ColorConstant.black95,
//                       borderRadius: BorderRadius.circular(32)
//                   ),
//                   child: TextFormField(
//                     onChanged: (value) => ref.watch(exampleTextFieldProvider.notifier).update((state) => value),
//                     textAlign: TextAlign.left,
//                     autofocus: true,
//                     cursorColor: ColorConstant.green40,
//                     decoration: InputDecoration(
//                       fillColor: ColorConstant.green95,
//                       filled: true,
//                       hintText: 'メッセージを入力',
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16),
//               GestureDetector(
//                 onTap: () {
//                   ref.read(chatRepositoryProvider).addChat(ChatEntity(
//                       myToken: ref.read(tokenProvider),
//                       opponentToken: oppToken,
//                       message: ref.watch(exampleTextFieldProvider),
//                       unread: 0,
//                       updateAt: DateTime.now()));
//                 },
//                 child: Icon(
//                   Icons.send,
//                   color: ColorConstant.green40,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }