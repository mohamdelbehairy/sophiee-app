import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/show_chat_image_page.dart';
import 'package:app/pages/chats/show_chat_video_page.dart';
import 'package:app/utils/widget/messages/custom_message_record.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_audio/custom_message_sound.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_contact.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_file/custom_message_file.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_text/custom_message_text.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/groups_high_light_custom_image.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/groups_high_light_custom_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getnav;
import 'package:url_launcher/url_launcher.dart';

class GroupsHighLightSubTitelBody extends StatelessWidget {
  const GroupsHighLightSubTitelBody(
      {super.key,
      required this.message,
      required this.size,
      required this.user});

  final MessageModel message;
  final Size size;
  final UserModel user;

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
              sliderWidth: message.replaySoundMessage != ''
                  ? size.width * .66
                  : size.width * .58,
              message: message,
              size: size,
              messageTextColor: Colors.white),
        if (message.messageSound != null)
          CustomMessageSound(
              message: message,
              size: size,
              user: user,
              messageTextColor: Colors.white),
        if (message.phoneContactNumber != null)
          GestureDetector(
              onTap: () async {
                String url = 'tel:${message.phoneContactNumber}';
                if (await canLaunchUrl(Uri(scheme: 'tel', path: url))) {
                  await launchUrl(Uri(scheme: 'tel', path: url));
                } else {
                  print('error');
                }
              },
              child: CustomMessageContact(message: message)),
        if (message.messageFile != null)
          CustomMessageFile(message: message, messageTextColor: Colors.white),
        if (message.messageVideo != null)
          GestureDetector(
              onTap: () => getnav.Get.to(
                  () => ShowChatVideoPage(user: user, message: message),
                  transition: getnav.Transition.downToUp),
              child: GroupsHighLightCustomVideo(message: message, size: size)),
        if (message.messageImage != null)
          GestureDetector(
              onTap: () => getnav.Get.to(
                  () => ShowChatImagePage(user: user, message: message),
                  transition: getnav.Transition.downToUp),
              child: GroupsHighLightCustomImage(message: message, size: size)),
        if (message.messageText != '')
          CustomMessageText(
              size: size,
              messageModel: message,
              messageTextColor: Colors.white),
      ],
    );
  }
}
