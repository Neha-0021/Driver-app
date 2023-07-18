import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const HomeButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
    this.width = 140,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFF192B46),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Publica Sans',
          fontWeight: FontWeight.w400,
          height: 2.3,
        ),
      ),
    );
  }
}