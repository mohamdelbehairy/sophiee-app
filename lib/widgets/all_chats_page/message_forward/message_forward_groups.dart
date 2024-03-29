import 'package:app/cubit/forward/forward_selected_group/forward_selected_group_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/message_forward/message_forward_group_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageForwardGroups extends StatelessWidget {
  const MessageForwardGroups(
      {super.key,
      required this.size,
      required this.isDark,
      required this.group,
      required this.selectedGroup});
  final Size size;
  final bool isDark;
  final CreateGroupsCubit group;
  final ForwardSelectedGroupCubit selectedGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding:
                EdgeInsets.only(left: size.width * .04, top: size.width * .01),
            child: Text('All Groups',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: isDark ? Colors.white : Colors.black))),
        SizedBox(
          height: size.height * .15,
          child: BlocBuilder<CreateGroupsCubit, CreateGroupsState>(
            builder: (context, state) {
              List<GroupModel> filteredGroups =
                  group.userGroupsList.where((userGroup) {
                return userGroup.usersID
                    .contains(FirebaseAuth.instance.currentUser!.uid);
              }).toList();
              return ListView.builder(
                  itemCount: filteredGroups.length,
                  itemBuilder: (context, index) {
                    return MessageForwardGroupListTile(
                        size: size,
                        groupModel: filteredGroups[index],
                        isDark: isDark);
                  });
            },
          ),
        ),
      ],
    );
  }
}
