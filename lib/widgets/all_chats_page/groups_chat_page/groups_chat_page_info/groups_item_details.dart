import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails(
      {super.key, required this.itemName, required this.itemValue});
  final String itemName;
  final String itemValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          bottom: size.height * .007,
          left: size.width * .04,
          right: size.width * .04),
      child: Row(
        children: [
          Text('$itemName:  ', style: TextStyle(color: Colors.grey)),
          Text(itemValue,
              style:
                  TextStyle(color: Colors.black, fontSize: size.height * .016)),
        ],
      ),
    );
  }
}