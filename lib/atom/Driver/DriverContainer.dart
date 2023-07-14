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
      width: 170,
      height: 120,
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 15),
                child: SvgPicture.asset(imagePath),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 18, left: 6), // Adjust the padding to your preference
                child: Text(
                  titleText,
                  style: const TextStyle(
                    color: Color(0xFF192B46),
                    fontSize: 12,
                    fontFamily: 'Publica Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
          const Divider(
            color: Colors.grey,
            indent: 25,
            endIndent: 25,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Text(
            subtitleText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF192B46),
              fontSize: 20,
              fontFamily: 'Publica Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
