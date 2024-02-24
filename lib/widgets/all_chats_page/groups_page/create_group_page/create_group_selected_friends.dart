import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_scubit.dart';
import 'package:app/widgets/all_chats_page/create_group_page/create_group_page_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupSelectedFriends extends StatelessWidget {
  const CreateGroupSelectedFriends({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var isDark = context.read<LoginCubit>().isDark;
    var selectedFriends = context.read<GroupsMemberSelectedCubit>();
    return Container(
      height: size.height * .3,
      width: size.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 40,
          color: Colors.grey.withOpacity(isDark ? .05 : .3),
        ),
      ]),
      child: Card(
        color: isDark ? Color(0xff2b2c33) : Colors.white,
        child: BlocBuilder<GetFriendsCubit, GetFriendsState>(
          builder: (context, state) {
            if (state is GetFriendsSuccess) {
              return ListView.builder(
                  itemCount: state.friends.length,
                  itemBuilder: (context, index) {
                    selectedFriends.getGroupsMemberSelectedFriends();
                    return CreateGroupListTile(
                        isDark: isDark, user: state.friends[index], size: size);
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}