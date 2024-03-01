import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageTextReplayImage extends StatelessWidget {
  const CustomMessageTextReplayImage(
      {super.key, required this.user, required this.message});
  final UserModel user;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .05,
      width: size.height * .2,
      color: message.senderID == FirebaseAuth.instance.currentUser!.uid
          ? Colors.white12
          : Colors.grey.withOpacity(.3),
      child: Row(
        children: [
          Container(
            height: size.height * .045,
            width: size.height * .039,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(message.replayImageMessage!),
                    fit: BoxFit.fitHeight)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<GetUserDataCubit, GetUserDataStates>(
                builder: (context, state) {
                  if (state is GetUserDataSuccess &&
                      state.userModel.isNotEmpty) {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      final currentData = state.userModel.firstWhere(
                          (element) => element.userID == currentUser.uid);
                      return Padding(
                        padding: EdgeInsets.only(
                            left: size.width * .02, top: size.height * .004),
                        child: Text(
                            message.senderID ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? currentData.userName
                                : user.userName,
                            style: TextStyle(
                                color: message.senderID ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? Colors.white
                                    : Colors.black)),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * .02),
                child: Text(
                    message.replayTextMessage != ''
                        ? message.replayTextMessage!
                        : 'Photo',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: message.senderID ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Colors.white
                            : Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}