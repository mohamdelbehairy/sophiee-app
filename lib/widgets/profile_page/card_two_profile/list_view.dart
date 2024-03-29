import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/widgets/profile_page/card_two_profile/friends_number_icon.dart';
import 'package:app/widgets/profile_page/card_two_profile/show_friends_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProfileListView extends StatelessWidget {
  const CustomProfileListView({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    return BlocBuilder<GetFriendsCubit, GetFriendsState>(
      builder: (context, state) {
        if (state is GetFriendsSuccess && state.friends.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.friends.length,
                itemBuilder: ((context, index) {
                  if (index == 4) {
                    return FriendsNumberIcon(
                        size: size, friendsNumber: state.friends.length - 4);
                  } else {
                    return ShowFriendsImage(
                        size: size, isDark: isDark, user: state.friends[index]);
                  }
                })),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

