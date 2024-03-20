import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/upload/upload_audio/upload_audio_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_body_details.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_chat_send_record.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_chat_send_text_message.dart';
import 'package:flutter/material.dart';

class CustomChatSendTextAndRecordItem extends StatelessWidget {
  const CustomChatSendTextAndRecordItem(
      {super.key,
      required this.isShowSendButton,
      required this.scrollController,
      required this.messages,
      required this.widget,
      required this.textEditingController,
      required this.isSwip,
      required this.messageModel,
      required this.userData,
      required this.uploadAudio});

  final bool isShowSendButton;
  final ScrollController scrollController;
  final MessageCubit messages;
  final ChatPageBodyDetails widget;
  final TextEditingController textEditingController;
  final bool isSwip;
  final MessageModel? messageModel;
  final UserModel? userData;
  final UploadAudioCubit uploadAudio;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 5,
        right: 5,
        child: isShowSendButton
            ? CustomChatSendTextMessage(
                scrollController: scrollController,
                messages: messages,
                widget: widget,
                textEditingController: textEditingController,
                isSwip: isSwip,
                messageModel: messageModel,
                userData: userData)
            : CustomChatSendRecord(
                uploadAudio: uploadAudio,
                messages: messages,
                widget: widget,
                isSwip: isSwip,
                messageModel: messageModel,
                userData: userData));
  }
}
