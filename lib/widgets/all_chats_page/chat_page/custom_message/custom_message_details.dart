import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_details_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CustomMessageDetails extends StatelessWidget {
  const CustomMessageDetails(
      {super.key,
      required this.alignment,
      required this.message,
      required this.size,
      required this.backGroundMessageColor,
      required this.user,
      required this.messageTextColor});

  final Alignment alignment;
  final MessageModel message;
  final Size size;
  final Color backGroundMessageColor;
  final UserModel user;
  final Color messageTextColor;


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: message.messageImage != null ||
                message.messageVideo != null ||
                message.messageFile != null ||
                message.phoneContactNumber != null ||
                message.replayTextMessage != '' ||
                message.replayFileMessage != '' ||
                message.replayImageMessage != '' ||
                message.replayContactMessage != ''
            ? null
            : message.messageText.length <= 5
                ? size.width * .15
                : message.messageText.length > 30
                    ? size.width * .8
                    : null,
        margin: EdgeInsets.symmetric(
            horizontal: size.width * .03, vertical: size.width * .003),
        padding: EdgeInsets.only(
            right: message.messageImage != null || message.messageVideo != null
                ? 0.0
                : message.messageFile != null
                    ? size.width * .02
                    : size.width * .01,
            left: message.messageFile != null ? 6 : 0,
            bottom: message.messageFile != null ? 6 : 0),
        decoration: BoxDecoration(
          color: message.messageImage != null && message.messageText == ''
              ? Colors.transparent
              : backGroundMessageColor,
          borderRadius: BorderRadius.only(
            topRight:
                Radius.circular(message.messageText.length <= 100 ? 16 : 24),
            topLeft: Radius.circular(
                message.receiverID == FirebaseAuth.instance.currentUser!.uid &&
                        message.messageText.length <= 100
                    ? 16
                    : 24),
            bottomRight: Radius.circular(
                message.senderID != FirebaseAuth.instance.currentUser!.uid
                    ? 24
                    : 0),
            bottomLeft: Radius.circular(
                message.senderID != FirebaseAuth.instance.currentUser!.uid
                    ? 0
                    : 24),
          ),
        ),
        child: CustomMessageDetailsBody(
          
            message: message,
            user: user,
            size: size,
            messageTextColor: messageTextColor),
      ),
    );
  }
}