import 'package:app/widgets/snackBar.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    getDarkMode().then((value) {
      isDark = value ?? false;
      emit(AppThemeChanged());
    });
  }

  Future<void> login(
      {required String emailAddress,
      required String password,
      required BuildContext context}) async {
    emit(LoginLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      if (userCredential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userID', userCredential.user!.uid);
        print(userCredential.user!.uid);
        emit(LoginSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(LoginFailure(errorMessage: 'invalid-credential'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }

  Future<void> forgetPassword(
      {required String emailAddress, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: SnackBarWidget(
              title: 'Password reset was successful',
              icon: Icons.check_circle,
              color: Colors.green,
              message: 'Please check your email and login again.'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  bool isDark = false;
  void changeAppTheme() {
    isDark = !isDark;
    emit(AppThemeChanged());
    // saveDarkMode(isDark: isDark);
  }

  Future<void> saveDarkMode({required bool isDark}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDark);
  }

  Future<bool?> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode');
  }
}
