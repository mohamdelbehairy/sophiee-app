import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups_chat_page.dart';
import 'package:app/widgets/all_chats_page/groups_page/custom_add_groups.dart';
import 'package:app/widgets/all_chats_page/groups_page/custom_create_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var group = context.read<CreateGroupsCubit>();
    group.getGroups();
    // group.displayGroupIfUserHasAccess();
    return Scaffold(
      body: BlocBuilder<CreateGroupsCubit, CreateGroupsState>(
        builder: (context, state) {
          List<GroupModel> filteredGroups =
              group.userGroupsList.where((userGroup) {
            return userGroup.usersID
                .contains(FirebaseAuth.instance.currentUser!.uid);
          }).toList();
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: filteredGroups.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .9,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return CustomCreateGroup();
                  } else {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupsChatPage(
                                  groupModel: filteredGroups[index - 1]))),
                      child: CustomAddGroups(
                          groupModel: filteredGroups[index - 1]),
                    );
                  }
                }),
          );
        },
      ),
    );
  }
}

// CustomCreateGroup()
