import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/features/notification/cubit/message_cubit.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';

class MessageDetailPage extends StatefulWidget {
  const MessageDetailPage(
      {Key? key, required this.id, required this.id_recever})
      : super(key: key);

  final int id;
  final int id_recever;

  @override
  State<MessageDetailPage> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = <String>[];

  void _handleSubmitted(String text) {
    context
        .read<MessageReplyCubit>()
        .getMessageReply(widget.id.toString(), _textController.text);
    _textController.clear();
    context.read<MessageCubit>().getDetailMessageList(widget.id.toString());
  }

  @override
  void initState() {
    context.read<MessageCubit>().getDetailMessageList(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Jean setone seri',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.video_call_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<MessageCubit, MessageState>(
              listener: (context, state) {},
              // buildWhen: (previous, current) =>
              //     current == MessageDetailStateLoaded ||
              //     previous == MessageDetailStateLoaded,
              builder: (context, state) {
                if (state is MessageDetailStateError) {
                  // Gérer l'état d'erreur
                } else if (state is MessageDetailStateLoading) {
                  // Afficher un indicateur de chargement
                } else if (state is MessageDetailStateLoaded) {
                  print(state.response.toString());
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemCount: state.response.details?.length ?? 0,
                      itemBuilder: (_, int index) {
                        var model = state.response.details?[index];
                        if (model != null) {
                          return Column(
                            children: [
                              widget.id_recever == model.sender?.id!
                                  ? getSenderView(
                                      ChatBubbleClipper4(
                                          type: BubbleType.sendBubble),
                                      context,
                                      model.message ?? '',
                                    )
                                  : getReceiverView(
                                      ChatBubbleClipper4(
                                          type: BubbleType.receiverBubble),
                                      context,
                                      model.message ?? '',
                                    ),
                              SizedBox(height: 20),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildTextComposer(),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLength: 600,
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration:
                  InputDecoration.collapsed(hintText: "envoyer votre message"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  getSenderView(CustomClipper clipper, BuildContext context, String text) =>
      ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.black,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context, String text) =>
      ChatBubble(
        clipper: clipper,
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           BlocBuilder<MessageCubit, MessageState>(
//             builder: (context, state) {
//               if (state is MessageDetailStateError) {
//                 // Gérer l'état d'erreur
//               } else if (state is MessageDetailStateLoading) {
//                 // Afficher un indicateur de chargement
//               } else if (state is MessageDetailStateLoaded) {
//                 print(state.response.toString());
//                 return SizedBox(height: MediaQuery.of(context).size.height,
//                   child: ListView.builder(
//                     padding: EdgeInsets.all(8.0),
//                     reverse: true,
//                     itemCount: state.response.details?.length ?? 0,
//                     itemBuilder: (_, int index) {
//                       var model = state.response.details?[index];
//                       if (model != null) {
//                         return Column(
//                           children: [
//                             widget.id_recever == model.sender?.id!
//                                 ? getSenderView(
//                                     ChatBubbleClipper4(
//                                         type: BubbleType.sendBubble),
//                                     context,
//                                     model.message ?? '',
//                                   )
//                                 : getReceiverView(
//                                     ChatBubbleClipper4(
//                                         type: BubbleType.receiverBubble),
//                                     context,
//                                     model.message ?? '',
//                                   ),
//                             SizedBox(height: 20),
//                           ],
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   ),
//                 );
//               }

//               return Container();
//             },
//           ),
//           const Divider(height: 1.0),
//         ],
//       ),
//       bottomNavigationBar: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Container(
//               decoration: BoxDecoration(color: Theme.of(context).cardColor),
//               child: _buildTextComposer(),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }

//   getTitleText(String title) => Text(
//         title,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 20,
//         ),
//       );

//   getSenderView(CustomClipper clipper, BuildContext context, String text) =>
//       ChatBubble(
//         clipper: clipper,
//         alignment: Alignment.topRight,
//         margin: EdgeInsets.only(top: 20),
//         backGroundColor: Colors.black,
//         child: Container(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width * 0.7,
//           ),
//           child: Text(
//             text,
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       );

//   getReceiverView(CustomClipper clipper, BuildContext context, String text) =>
//       ChatBubble(
//         clipper: clipper,
//         backGroundColor: Color(0xffE7E7ED),
//         margin: EdgeInsets.only(top: 20),
//         child: Container(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width * 0.7,
//           ),
//           child: Text(
//             text,
//             style: TextStyle(color: Colors.black),
//           ),
//         ),
//       );

//   Widget _buildTextComposer() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: TextField(
//               maxLength: 600,
//               controller: _textController,
//               onSubmitted: _handleSubmitted,
//               decoration:
//                   InputDecoration.collapsed(hintText: "envoyer votre message"),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.photo),
//             onPressed: () => _handleSubmitted(_textController.text),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () => _handleSubmitted(_textController.text),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildMessage(
//   //   String message,
//   //   bool iSsend,
//   // ) {
//   //   return Container(
//   //     margin: EdgeInsets.symmetric(vertical: 5.0),
//   //     child: Row(
//   //       crossAxisAlignment:
//   //           iSsend ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//   //       mainAxisAlignment:
//   //           iSsend ? MainAxisAlignment.start : MainAxisAlignment.end,
//   //       children: <Widget>[
//   //         if (iSsend) Spacer(),
//   //         if (iSsend) SizedBox(width: 40),
//   //         Container(
//   //           padding: EdgeInsets.all(20),
//   //           decoration: BoxDecoration(
//   //             boxShadow: [
//   //               BoxShadow(
//   //                 color: Colors.grey.withOpacity(0.5),
//   //                 spreadRadius: 2,
//   //                 blurRadius: 2,
//   //                 offset: Offset(0, 3),
//   //               ),
//   //             ],
//   //             borderRadius: BorderRadius.all(Radius.circular(20)),
//   //             color: iSsend ? Colors.black : Colors.white,
//   //           ),
//   //           margin: EdgeInsets.only(top: 5.0),
//   //           child: SingleChildScrollView(
//   //             scrollDirection: Axis.vertical,
//   //             child: Text(
//   //               message + 'dfgvuhjbkl,m;ù*dfgrhjklm',
//   //               style: TextStyle(color: iSsend ? Colors.white : Colors.black),
//   //             ),
//   //           ),
//   //         ),
//   //         if (!iSsend) Spacer(),
//   //         if (!iSsend) SizedBox(width: 40),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
