import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const YellowButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 40,
      decoration: ShapeDecoration(
        color: Color(0xFFECB21E),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFECB21E),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'PublicaSans',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 2.5,
          letterSpacing: 0,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
