import 'package:app/cubit/user_date/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/user_date/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/cubit/groups/message_group/group_message_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/widget/replay_to_message/replay_audio_message.dart';
import 'package:app/utils/widget/replay_to_message/replay_contact_message.dart';
import 'package:app/utils/widget/replay_to_message/replay_file_message.dart';
import 'package:app/utils/widget/replay_to_message/replay_image_message.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/custom_group_send_text_and_record_item.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_custom_message/groups_chat_custom_message_component_body.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_custom_send_media.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_not_send_message.dart';
import 'package:app/utils/widget/replay_to_message/replay_text_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';

class GroupsChatPageBodyDetails extends StatefulWidget {
  const GroupsChatPageBodyDetails(
      {super.key,
      required this.groupModel,
      required this.scrollController,
      required this.controller,
      required this.isShowSendButton,
      required this.onChanged,
      required this.size});
  final GroupModel groupModel;
  final ScrollController scrollController;
  final TextEditingController controller;
  final bool isShowSendButton;
  final Function(String) onChanged;
  final Size size;

  @override
  State<GroupsChatPageBodyDetails> createState() =>
      _GroupsChatPageBodyDetailsState();
}

class _GroupsChatPageBodyDetailsState extends State<GroupsChatPageBodyDetails> {
  bool isSwip = false;

  MessageModel? messageModel;
  UserModel? userData;
  late FocusNode focusNode;

  @override
  void initState() {
    

    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var groupChat = context.read<GroupMessageCubit>();
    return Stack(
      children: [
        Column(
          children: [
            // GroupsChatPageBodyListView(
            //     scrollController: scrollController, groupModel: groupModel),
            BlocConsumer<GroupMessageCubit, GroupMessageState>(
              listener: (context, state) {
                if (state is GetMessageGroupsSuccess ||
                    state is SendMessageGroupSuccess) {
                  setState(() {
                    isSwip = false;
                  });
                }
              },
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: widget.scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: groupChat.groupMessageList.length,
                      itemBuilder: (context, index) {
                        var message = context
                            .read<GroupMessageCubit>()
                            .groupMessageList[index];
                        if (message.senderID !=
                            FirebaseAuth.instance.currentUser!.uid) {
                          groupChat.updateGroupsChatMessageSeen(
                              groupID: widget.groupModel.groupID,
                              messageID: message.messageID,
                              groupChatUsersIDSeen: [
                                FirebaseAuth.instance.currentUser!.uid
                              ]);
                        }
                        return SwipeTo(
                          onLeftSwipe: (details) {
                            setState(() {
                              isSwip = !isSwip;
                              messageModel = message;
                              focusNode.requestFocus();
                            });
                          },
                          key: Key(message.messageID),
                          child: GroupsChatCustomMessageComponentBody(
                              groupModel: widget.groupModel,
                              message: message,
                              size: widget.size),
                        );
                      }),
                );
              },
            ),

            SizedBox(height: widget.size.height * .01),
            if (widget.groupModel.isSendMessages ||
                widget.groupModel.groupOwnerID ==
                    FirebaseAuth.instance.currentUser!.uid ||
                widget.groupModel.adminsID
                    .contains(FirebaseAuth.instance.currentUser!.uid))
              Column(
                children: [
                  if (isSwip)
                    if (messageModel!.messageText != '' &&
                        messageModel!.messageImage == null &&
                        messageModel!.messageFileName == null)
                      ReplayTextMessage(
                          groupModel: widget.groupModel,
                          messageModel: messageModel!,
                          onTap: () {
                            setState(() {
                              isSwip = false;
                            });
                          }),
                  if (isSwip)
                    if (messageModel!.messageImage != null &&
                        messageModel!.messageText == '')
                      ReplayImageMessage(
                          messageModel: messageModel!,
                          groupModel: widget.groupModel,
                          onTap: () {
                            setState(() {
                              isSwip = false;
                            });
                          }),
                  if (isSwip)
                    if (messageModel!.messageImage != null &&
                        messageModel!.messageText != '')
                      ReplayImageMessage(
                          messageModel: messageModel!,
                          groupModel: widget.groupModel,
                          onTap: () {
                            setState(() {
                              isSwip = false;
                            });
                          }),
                  if (isSwip)
                    if (messageModel!.messageFile != null)
                      ReplayFileMessage(
                        messageModel: messageModel!,
                        groupModel: widget.groupModel,
                        onTap: () {
                          setState(() {
                            isSwip = false;
                          });
                        },
                      ),
                  if (isSwip)
                    if (messageModel!.phoneContactNumber != null)
                      ReplayContactMessage(
                          messageModel: messageModel!,
                          groupModel: widget.groupModel,
                          onTap: () {
                            setState(() {
                              isSwip = false;
                            });
                          }),
                  if (isSwip)
                    if (messageModel!.messageSound != null)
                      ReplayAudioMessage(
                          messageModel: messageModel!,
                          groupModel: widget.groupModel,
                          onTap: () {
                            setState(() {
                              isSwip = false;
                            });
                          }),
                  if (isSwip)
                    if (messageModel!.messageRecord != null)
                      ReplayAudioMessage(
                          messageModel: messageModel!,
                          groupModel: widget.groupModel,
                          onTap: () {
                            setState(() {
                              isSwip = false;
                            });
                          }),
                  if (isSwip) SizedBox(height: widget.size.width * .01),
                  BlocBuilder<GetUserDataCubit, GetUserDataStates>(
                    builder: (context, state) {
                      if (state is GetUserDataSuccess &&
                          state.userModel.isNotEmpty) {
                        if (isSwip) {
                          final currentUser = messageModel!.senderID;
                          userData = state.userModel.firstWhere(
                              (element) => element.userID == currentUser);
                        }
                      }
                      return GroupsChatPageCustomSendMedia(
                        userData: userData,
                        messageModel: messageModel,
                        isSwip: isSwip,
                        focusNode: focusNode,
                        onChanged: widget.onChanged,
                        scrollController: widget.scrollController,
                        controller: widget.controller,
                        size: widget.size,
                        groupModel: widget.groupModel,
                      );
                    },
                  ),
                ],
              ),
            if (!widget.groupModel.isSendMessages &&
                widget.groupModel.groupOwnerID !=
                    FirebaseAuth.instance.currentUser!.uid &&
                !widget.groupModel.adminsID
                    .contains(FirebaseAuth.instance.currentUser!.uid))
              GroupsChatPageNotSendMessage(size: widget.size)
          ],
        ),
        if (widget.groupModel.isSendMessages ||
            widget.groupModel.groupOwnerID ==
                FirebaseAuth.instance.currentUser!.uid ||
            widget.groupModel.adminsID
                .contains(FirebaseAuth.instance.currentUser!.uid))
          CustomGroupSendTextAndRecordItem(
              stopRecording: (value) {
                setState(() {
                  isSwip = false;
                });
              },
              userData: userData,
              messageModel: messageModel,
              isSwip: isSwip,
              isShowSendButton: widget.isShowSendButton,
              controller: widget.controller,
              groupModel: widget.groupModel,
              scrollController: widget.scrollController,
              size: widget.size),
      ],
    );
  }
}
