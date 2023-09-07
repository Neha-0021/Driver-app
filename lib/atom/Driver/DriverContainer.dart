import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverContainer extends StatelessWidget {
  final String titleText;
  final String imagePath;
  final String subtitleText;

  const DriverContainer({
    Key? key,
    required this.titleText,
    required this.imagePath,
    required this.subtitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 18,
            offset: Offset(3, 2),
            spreadRadius: -9,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                SvgPicture.asset(imagePath),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    titleText,
                    style: const TextStyle(
                      color: Color(0xFF192B46),
                      fontSize: 12,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            child: const Divider(
              color: Color(0xFFD2DBD6),
              thickness: 1.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              subtitleText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF192B46),
                fontSize: 20,
                fontFamily: 'PublicaSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
