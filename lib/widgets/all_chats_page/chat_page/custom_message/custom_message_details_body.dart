import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_message_sound.dart';
import 'package:app/utils/widget/messages/custom_message_record.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/custom_message_text.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_contact.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_file/custom_message_file.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_image/custom_message_image.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_video.dart';
import 'package:flutter/material.dart';

class CustomMessageDetailsBody extends StatelessWidget {
  const CustomMessageDetailsBody(
      {super.key,
      required this.message,
      required this.user,
      required this.size,
      required this.messageTextColor,
      required this.backgroundMessageColor});

  final MessageModel message;
  final UserModel user;
  final Size size;
  final Color messageTextColor;
  final Color backgroundMessageColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: message.messageImage != null ||
              message.messageVideo != null && message.messageText != '' ||
              message.messageFile != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        if (message.messageRecord != null)
          CustomMessageRecord(
              message: message, size: size, messageTextColor: messageTextColor),
        if (message.messageSound != null)
          CustomMessageSound(
              message: message,
              size: size,
              user: user,
              messageTextColor: messageTextColor),
        if (message.phoneContactNumber != null)
          CustomMessageContact(message: message),
        if (message.messageFile != null)
          CustomMessageFile(
              message: message, user: user, messageTextColor: messageTextColor),
        if (message.messageVideo != null)
          CustomMessageVideo(message: message, user: user),
        if (message.messageImage != null && message.messageText == '')
          CustomMessageImage(
              size: size,
              message: message,
              user: user,
              backgroundMessageColor: backgroundMessageColor,
              messageColor: messageTextColor),
        if (message.messageImage != null && message.messageText != '')
          CustomMessageImage(
              size: size,
              message: message,
              user: user,
              backgroundMessageColor: backgroundMessageColor,
              messageColor: messageTextColor),
        if (message.messageText != '')
          CustomMessageText(
              size: size,
              messageModel: message,
              messageTextColor: messageTextColor),
      ],
    );
  }
}
