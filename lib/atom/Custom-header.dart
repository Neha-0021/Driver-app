import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String? headerText;
  final Color? iconColor;
  final Color? textColor;

  CustomHeader({Key? key, this.headerText, this.iconColor, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color defaultTextColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black;
    final Color headerTextColor = textColor ?? defaultTextColor;

    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor ?? headerTextColor),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        Text(
          headerText ?? "",
          style: const TextStyle(
            fontFamily: 'PublicaSans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
            letterSpacing: 0,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ],
    );
  }
}