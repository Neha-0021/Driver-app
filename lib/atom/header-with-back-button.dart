import 'package:flutter/material.dart';

class HeaderwithBackButton extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final VoidCallback onPressed;

  const HeaderwithBackButton({
    required this.titleText,
    required this.subtitleText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      decoration: const BoxDecoration(
        color: Color(0xFF192B46),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      titleText,
                      style: const TextStyle(
                        fontFamily: 'PublicaSans',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    subtitleText,
                    style: const TextStyle(
                      fontFamily: 'PublicaSans',
                      color: Color(0XFF75879B),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
