import 'dart:io';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_image_page_body.dart';
import 'package:flutter/material.dart';

class PickImagePage extends StatelessWidget {
  const PickImagePage(
      {super.key,
      required this.image,
      required this.user,
      required this.replayTextMessageImage,
      required this.replayImageMessageImage,
      required this.replayFileMessageImage, required this.replayContactMessageContact});
  final File image;
  final UserModel user;
  final String replayTextMessageImage;
  final String replayImageMessageImage;
  final String replayFileMessageImage;
  final String replayContactMessageContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PickImagePageBody(
        image: image,
        user: user,
        replayTextMessageImage: replayTextMessageImage,
        replayImageMessageImage: replayImageMessageImage,
        replayFileMessageFile: replayFileMessageImage,
        replayContactMessageContact: replayContactMessageContact,
      ),
    );
  }
}
