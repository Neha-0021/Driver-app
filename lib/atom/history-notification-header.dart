import 'package:flutter/material.dart';

class HistoryNotificationHeader extends StatelessWidget {
  final String Titletext;
  final String subtitletext;

  const HistoryNotificationHeader({
    super.key,
    required this.Titletext,
    required this.subtitletext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF192B46),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              Titletext,
              style: const TextStyle(
                fontFamily: 'PublicaSans',
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              subtitletext,
              style: const TextStyle(
                fontFamily: 'PublicaSans',
                color: Color(0XFF75879B),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
