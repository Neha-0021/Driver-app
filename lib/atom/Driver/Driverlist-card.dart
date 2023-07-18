import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverListCard extends StatelessWidget {
  final String offerText;
  final String subText;
  final String subTitleText;
  final String imagePath;
  final String imagePathProfile;

  const DriverListCard({
    Key? key,
    required this.offerText,
    required this.subText,
    required this.subTitleText,
    required this.imagePath,
    required this.imagePathProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFD2DBD6),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                imagePathProfile,
                height: 31,
                width: 31,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    offerText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    subText,
                    style: const TextStyle(
                      color: Color(0xFF75879B),
                      fontSize: 10,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.green,
                  ),
                  Text(
                    subTitleText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
