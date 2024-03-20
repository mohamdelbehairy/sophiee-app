import 'package:app/cubit/pick_contact/pick_contact_cubit.dart';
import 'package:app/cubit/pick_contact/pick_contact_state.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/cubit/pick_file/pick_file_state.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/cubit/pick_video/pick_video_cubit.dart';
import 'package:app/cubit/pick_video/pick_video_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_pick_file_page.dart';
import 'package:app/pages/chats/groups/groups_chat_pick_image_page.dart';
import 'package:app/pages/chats/groups/groups_chat_pick_sound_page.dart';
import 'package:app/pages/chats/groups/groups_chat_pick_video_page.dart';
import 'package:app/utils/widget/chats/chat_choose_media.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_message_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class GroupsChatPageSendMedia extends StatefulWidget {
  const GroupsChatPageSendMedia(
      {super.key,
      required this.size,
      required this.scrollController,
      required this.groupModel,
      required this.controller, required this.onChanged});
  final Size size;
  final ScrollController scrollController;
  final GroupModel groupModel;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  State<GroupsChatPageSendMedia> createState() =>
      _GroupsChatPageSendMediaState();
}

class _GroupsChatPageSendMediaState extends State<GroupsChatPageSendMedia> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isClick) ChatChooseMedia(size: widget.size),
        BlocListener<PickImageCubit, PickImageStates>(
          listener: (context, state) {
            if (state is PickImageScucccess) {
              getnav.Get.to(
                  () => GroupsChatPickImagePage(
                      image: state.image, groupModel: widget.groupModel),
                  transition: getnav.Transition.leftToRight);
              setState(() {
                isClick = false;
              });
            }
          },
          child: BlocListener<PickFileCubit, PickFileState>(
            listener: (context, state) {
              if (state is PickFileSuccess) {
                final file = state.file;
                if ((file.path.toLowerCase().endsWith('.pdf') ||
                    file.path.toLowerCase().endsWith('.doc'))) {
                  getnav.Get.to(
                      () => GroupsChatPickFilePage(
                          file: state.file, groupModel: widget.groupModel),
                      transition: getnav.Transition.leftToRight);
                }
                if (file.path.toLowerCase().endsWith('.mp3')) {
                  getnav.Get.to(() => GroupsChatPickSoundPage(
                      sound: file,
                      size: widget.size,
                      groupModel: widget.groupModel));
                }

                setState(() {
                  isClick = false;
                });
              }
            },
            child: BlocListener<PickVideoCubit, PickVideoState>(
              listener: (context, state) {
                if (state is PickVideoSuccess) {
                  getnav.Get.to(
                      () => GroupsChatPickVideoPage(
                          video: state.video, groupModel: widget.groupModel),
                      transition: getnav.Transition.leftToRight);
                  setState(() {
                    isClick = false;
                  });
                }
              },
              child: BlocListener<PickContactCubit, PickContactState>(
                listener: (context, state) {
                  if (state is PickContactSuccess) {
                    setState(() {
                      isClick = false;
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      right: widget.size.width * .12,
                      bottom: widget.size.width * .01),
                  child: GroupChatMessageTextField(
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      onPressed: () {
                        setState(() {
                          isClick = !isClick;
                        });
                      }),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
