import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileList extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? actionImagePath;

  const ProfileList({
    required this.imagePath,
    required this.title,
    this.actionImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFD2DBD6),
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SvgPicture.asset(imagePath),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontFamily: 'PublicaSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF192B46),
                        decoration: TextDecoration.none),
                  ),
                ),
                if (actionImagePath != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(actionImagePath!, width: 6, height: 9),
                  ),
              ],
            )));
  }
}
