import 'package:flutter/material.dart';

class HomeButtonn extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  const HomeButtonn({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 40,
      decoration: ShapeDecoration(
        color: Color(0xFF192B46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Publica Sans',
            fontWeight: FontWeight.w400,
            height: 2.3),
      ),
    );
  }
}
