import 'package:app/constants.dart';
import 'package:app/cubit/update_user_data/update_user_cubit_cubit.dart';
import 'package:app/cubit/update_user_data/update_user_data_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/edit_profile_page/edit_profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfileNickName extends StatefulWidget {
  const EditProfileNickName({super.key, required this.user});
  final UserModel user;

  @override
  State<EditProfileNickName> createState() => _EditProfileNickNameState();
}

class _EditProfileNickNameState extends State<EditProfileNickName> {
  late TextEditingController nickName;
  bool showProgressIndicator = false;

  void onTap() async {
    showProgressIndicator = true;
    setState(() {});
    var updateNickName = context.read<UpdateUserDataCubit>();
    await Future.delayed(Duration(seconds: 2));

    if (nickName.text.isNotEmpty) {
      updateNickName.updateUserData(field: 'nickName', userInfo: nickName.text);
      navigatorPop();
    }
  }

  void navigatorPop() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    nickName = TextEditingController(text: widget.user.nickName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUserDataCubit, UpdateUserDataStates>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: showProgressIndicator,
          progressIndicator: Center(
              child: LoadingAnimationWidget.prograssiveDots(
                  color: kPrimaryColor, size: 50)),
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: -5,
              backgroundColor: kPrimaryColor,
              title: Text(
                'Edit Nick Name',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              leading: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              actions: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    if (nickName.text.isNotEmpty &&
                        nickName.text != widget.user.nickName) {
                      onTap();
                    }
                  },
                  icon: Icon(Icons.done, color: Colors.white, size: 30),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  EditProfileTextField(
                    hintText: 'nickName',
                    controller: nickName,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
