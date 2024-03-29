import 'dart:io';

import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_items/pick_video_page_body.dart';
import 'package:flutter/material.dart';

class PickVideoPage extends StatelessWidget {
  const PickVideoPage({super.key, required this.video, required this.user});
  final File video;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PickVideoPageBody(video: video, user: user),
    );
  }
}
