import 'package:app/constants.dart';
import 'package:app/cubit/follow_status/follow_status_cubit.dart';
import 'package:app/cubit/follower/follower_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/models/users_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultPageBodyBottom extends StatelessWidget {
  const SearchResultPageBodyBottom(
      {super.key, required this.user, required this.userData});
  final UserModel user;
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final follower = context.read<FollowerCubit>();

    return BlocBuilder<FollowStatusCubit, bool>(
      builder: (context, isFollowing) {
        return GestureDetector(
          onTap: () async {
            context.read<GetFollowersCubit>().getFollowers(userID: user.userID);
            context.read<GetFollowingCubit>().getFollowing(userID: user.userID);
            if (isFollowing) {
              await follower.deleteFollower(followerID: user.userID);
            } else {
              follower.addFollower(
                  followerID: user.userID,
                  userName: user.userName,
                  profileImage: user.profileImage,
                  userID: user.userID,
                  emailAddress: user.emailAddress,
                  isFollowing: !isFollowing,
                  meUserName: userData.userName,
                  meProfileImage: userData.profileImage,
                  meEmailAddress: userData.emailAddress);
            }
          },
          child: Container(
            height: size.height * .04,
            width: size.width * .2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height * .04),
              color: isFollowing ? Colors.white : kPrimaryColor,
              border: isFollowing
                  ? Border.all(color: Colors.grey.withOpacity(.2))
                  : Border.all(color: Colors.transparent),
            ),
            child: Center(
              child: Text(
                isFollowing ? 'Following' : 'Follow',
                style: TextStyle(
                  fontSize: size.width * .03,
                  color: isFollowing ? kPrimaryColor : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
