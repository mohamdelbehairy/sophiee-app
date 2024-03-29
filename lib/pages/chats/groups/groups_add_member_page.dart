import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_members_page/groups_chat_add_members/groups_add_member_page_body.dart';
import 'package:flutter/material.dart';

class GroupsAddMemberPage extends StatelessWidget {
  const GroupsAddMemberPage(
      {super.key, required this.size, required this.groupModel});
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Add members',
          style: TextStyle(
              color: Colors.white,
              fontSize: size.height * .028,
              fontWeight: FontWeight.normal),
        ),
      ),
      body: GroupsAddMemberPageBody(size: size, groupModel: groupModel),
    );
  }
}
