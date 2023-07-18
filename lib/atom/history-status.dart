import 'package:flutter/material.dart';

class HistoryStatus extends StatelessWidget {
  final Color containerColor;
  final String labelText;

  HistoryStatus({
    required this.containerColor,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17,
      width: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: containerColor,
      ),
      child: Center(
        child: Text(
          labelText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontFamily: 'PublicaSans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
