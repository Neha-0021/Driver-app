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
            Container(
              padding: const EdgeInsets.only(left: 21),
              width: 60,
              child: Image.asset(imagePathProfile),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 20),
                  child: Text(
                    offerText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Publica Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    subText,
                    style: const TextStyle(
                      color: Color(0xFF75879B),
                      fontSize: 10,
                      fontFamily: 'Publica Sans',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(imagePath),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 10),
              child: Text(
                subTitleText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
