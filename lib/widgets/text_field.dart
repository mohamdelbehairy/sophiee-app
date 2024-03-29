import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      this.textInputType,
      this.onChanged,
      required this.validator,
      this.controller});
  final String hintText;
  final bool obscureText;
  final TextInputType? textInputType;
  final Function(String?)? onChanged;
  final String? Function(String?) validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: textInputType,
      cursorColor: const Color(0xff2b2c33),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: const Color(0xff2b2c33).withOpacity(.1),
        border: InputBorder.none,
        hintText: hintText,
      ),
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
    );
  }
}
