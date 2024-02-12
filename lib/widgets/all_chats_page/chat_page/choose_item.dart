import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class CustomChooseItem extends StatelessWidget {
  const CustomChooseItem({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: kPrimaryColor,
        child: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
