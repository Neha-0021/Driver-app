import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final Color color;
  final bool disabled;

  const MapButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.width,
    required this.color,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: color, // Use the provided color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: Size(width, 40),
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'PublicaSans',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
