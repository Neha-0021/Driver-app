import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool disabled;

  CustomButton({
    required this.label,
    this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor =
        disabled ? Colors.grey : const Color.fromRGBO(25, 43, 70, 1);

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor,
      ),
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'PublicaSans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
