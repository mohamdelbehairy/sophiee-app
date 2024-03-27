import 'package:app/constants.dart';
import 'package:app/models/media_files_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/media/positioned_video_icon.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

class TabBarMediaVideo extends StatefulWidget {
  const TabBarMediaVideo(
      {super.key, required this.mediaFiels, required this.size});
  final MediaFilesModel mediaFiels;
  final Size size;

  @override
  State<TabBarMediaVideo> createState() => _TabBarMediaVideoState();
}

class _TabBarMediaVideoState extends State<TabBarMediaVideo> {
  late VideoPlayerController _videoPlayerController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.mediaFiels.messageVideo!),
    )..initialize().then((value) {
        setState(() {
          _isLoading = false;
          // videoPlayerController.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: LoadingAnimationWidget.discreteCircle(
                color: kPrimaryColor, size: widget.size.height * .04))
        : Stack(
            children: [
              VideoPlayer(_videoPlayerController),
              PositionedVideoIcon(
                  size: widget.size, mediaFiels: widget.mediaFiels)
            ],
          );
  }
}
