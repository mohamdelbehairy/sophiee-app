import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/show_chat_video_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class CustomMessageVideo extends StatefulWidget {
  const CustomMessageVideo(
      {super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  State<CustomMessageVideo> createState() => _CustomMessageVideoState();
}

class _CustomMessageVideoState extends State<CustomMessageVideo> {
  late VideoPlayerController _videoPlayerController;
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();
    _isPlaying = false;
    if (widget.message.messageVideo != null) {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.message.messageVideo!),
      )..initialize().then((_) {
          setState(() {
            _videoPlayerController.setLooping(false);
            _isPlaying = true;
            _videoPlayerController.addListener(_videoListener);
          });
        });
    }
  }

  void _videoListener() {
    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      setState(() {
        _isPlaying = false;
        _videoPlayerController.pause();
        _videoPlayerController.seekTo(Duration.zero);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.message.messageVideo != null) {
      _videoPlayerController.removeListener(_videoListener);
      _videoPlayerController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_videoPlayerController.value.isPlaying) {
            _videoPlayerController.pause();
          } else {
            _videoPlayerController.play();
          }
          _isPlaying = !_isPlaying;
        });
      },
      child: Stack(
        children: [
          Container(
            height: size.width * .6,
            width: size.width * .6,
            child: VideoPlayer(_videoPlayerController),
          ),
          if (!_videoPlayerController.value.isPlaying)
            Positioned.fill(
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Color(0xff585558).withOpacity(.3),
                  child: Icon(
                    FontAwesomeIcons.play,
                    color: Colors.white,
                    size: size.width * .05,
                  ),
                ),
              ),
            ),
          if (_videoPlayerController.value.isPlaying)
            Positioned(
                bottom: size.height * .005,
                left: size.height * .005,
                child: GestureDetector(
                  onTap: () {
                    _videoPlayerController.pause();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowChatVideoPage(
                                message: widget.message, user: widget.user)));
                  },
                  child: Icon(FontAwesomeIcons.expand,
                      color: Colors.white, size: size.width * .04),
                ))
        ],
      ),
    );
  }
}
