import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListTilePostionedFriendDetails extends StatelessWidget {
  const ListTilePostionedFriendDetails(
      {super.key,
      required this.size,
      required this.user,
      required this.message,
      this.groupModel,
      this.userData});

  final Size size;
  final UserModel user;
  final UserModel? userData;
  final MessageModel message;
  final GroupModel? groupModel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.width * .013,
      left: size.width * .013,
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding:
              EdgeInsets.only(left: size.width * .013, right: size.width * .02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: size.height * .015,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: FancyShimmerImage(
                              boxFit: BoxFit.cover,
                              imageUrl: user.profileImage))),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .015),
                      child: Text(
                          message.senderID ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? 'You'
                              : user.userName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * .035,
                              fontWeight: FontWeight.normal))),
                  Icon(FontAwesomeIcons.play, size: size.width * .02),
                  if (groupModel != null)
                    Padding(
                        padding: EdgeInsets.only(left: size.width * .015),
                        child: Text(groupModel!.groupName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * .035,
                                fontWeight: FontWeight.normal))),
                  if (groupModel == null)
                    Padding(
                        padding: EdgeInsets.only(left: size.width * .015),
                        child: Text(
                            message.senderID == userData!.userID
                                ? 'you'
                                : userData!.userName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * .035,
                                fontWeight: FontWeight.normal))),
                ],
              ),
              Text(
                  '${Timestamp.now().toDate().difference(message.messageDateTime).inDays < 1 ? message.showChatImageTime() : Timestamp.now().toDate().difference(message.messageDateTime).inDays == 1 || message.messageDateTime.hour < 00 ? 'Yesterday' : message.showHighLightTime()} ',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: size.width * .03,
                      fontWeight: FontWeight.w100))
            ],
          ),
        ),
      ),
    );
  }
}
