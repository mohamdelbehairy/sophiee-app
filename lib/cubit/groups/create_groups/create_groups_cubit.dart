import 'dart:io';

import 'package:app/cubit/groups/create_groups/create_groups_state.dart';
import 'package:app/models/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateGroupsCubit extends Cubit<CreateGroupsState> {
  CreateGroupsCubit() : super(CreateGroupsInitial());

  bool isLoading = false;
  Future<void> createGroups(
      {required List<String> usersID,
      required String groupName,
      File? groupImageFile,
      required String groupImageUrl}) async {
    try {
      usersID.add(FirebaseAuth.instance.currentUser!.uid);
      GroupModel groupModel = GroupModel.fromJson({
        'groupID': Uuid().v1(),
        'groupName': groupName,
        'groupImage': groupImageFile != null
            ? groupImageUrl
            : 'https://he.cecollaboratory.com/public/layouts/images/group-default-logo.png',
        'createUserID': FirebaseAuth.instance.currentUser!.uid,
        'usersID': usersID,
        'groupCreateAt': Timestamp.now()
      });

      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupModel.groupID)
          .set(groupModel.toMap());
      // addGroupIDToUser(groupID: groupModel.groupID, usersID: usersID);
      isLoading = false;
      emit(CreateGroupsSuccess());
    } catch (e) {
      isLoading = false;
      debugPrint('error from create groups method: ${e.toString()}');
      emit(CreateGroupsFailure(errorMessage: e.toString()));
    }
    emit(UploadGroupImageLoading(isLoading: false));
  }

  Future<String> uploadGroupImage({required File? groupImageFile}) async {
    try {
      if (groupImageFile == null) {
        emit(UploadGroupImageLoading(isLoading: true));
        return '';
      } else {
        emit(UploadGroupImageLoading(isLoading: true));
        String groupImageName =
            DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference = FirebaseStorage.instance
            .ref()
            .child('group_name_images/$groupImageName');
        await reference.putFile(groupImageFile);
        String groupImageUrl = await reference.getDownloadURL();
        emit(UploadGroupImageSuccess());
        isLoading = false;
        return groupImageUrl;
      }
    } catch (e) {
      emit(UploadGroupImageFailure(errorMessage: e.toString()));
      emit(UploadGroupImageLoading(isLoading: false));
      debugPrint('error from upload group image: ${e.toString()}');
      return '';
    }
  }

  List<GroupModel> userGroupsList = [];
  void getGroups() {
    try {
      FirebaseFirestore.instance
          .collection('groups')
          .snapshots()
          .listen((snapshot) {
        userGroupsList.clear();
        for (var group in snapshot.docs) {
          userGroupsList.add(GroupModel.fromJson(group.data()));
        }
        emit(GetGroupSuccess());
      });
    } catch (e) {
      debugPrint('error fetching user groups: ${e.toString()}');
      emit(GetGroupFailure(errorMessage: e.toString()));
    }
  }
}