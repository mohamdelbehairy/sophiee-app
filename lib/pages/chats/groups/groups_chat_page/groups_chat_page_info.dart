import 'package:app/constants.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_cubit.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_info/groups_chat_info_body.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_info/groups_chat_page_info_app_bar.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_info/groups_info_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatPageInfo extends StatelessWidget {
  const GroupsChatPageInfo({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: const GroupsChatPageInfoAppBar(),
          actions: [
            BlocBuilder<GetGroupsMemberCubit, GetGroupsMemberState>(
              builder: (context, state) {
                if (state is GetGroupsMemberSuccess &&
                    state.groupsList.isNotEmpty) {
                  final groupID = groupModel.groupID;
                  final groupData = state.groupsList
                      .firstWhere((element) => element.groupID == groupID);
                  return GroupsInfoPopupMenueButton(
                      size: size, groupModel: groupData);
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        body: GroupsChatInfoBody(groupModel: groupModel));
  }
}
