import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/replaying_message_item_component.dart';
import 'package:flutter/material.dart';

class ReplayMessageTextComponent extends StatelessWidget {
  const ReplayMessageTextComponent(
      {super.key,
      required this.messageModel,
      required this.size,
      required this.messageTextColor});
  final MessageModel messageModel;
  final Size size;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: messageModel.replayTextMessage != '' ||
              messageModel.replayImageMessage != ''
          ? size.width * .35
          : messageModel.replayFileMessage != ''
              ? size.width * .45
              : messageModel.replayContactMessage != ''
                  ? size.width * .35
                  : 0.0,
      child: ReplayingMessageItemComponent(
        width: size.width * .55,
          messageModel: messageModel,
          size: size,
          messageTextColor: messageTextColor),
    );
  }
}