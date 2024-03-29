import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/utils/shimmer/home/all_chats/groups/groups_page_shimmer.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_page_body.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    var size = MediaQuery.of(context).size;
    var group = context.read<CreateGroupsCubit>();
    group.getGroups();

    return Scaffold(body: BlocBuilder<ConnectivityCubit, ConnectivityResult>(
      builder: (context, state) {
        if (state == ConnectivityResult.wifi ||
            state == ConnectivityResult.mobile) {
          return GroupsPageBody(group: group);
        } else {
          return GroupsChatShimmer(isDark: isDark,size: size);
        }
      },
    ));
  }
}



// CustomCreateGroup()
