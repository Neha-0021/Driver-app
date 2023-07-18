import 'package:flutter/material.dart';

class CustomerDetails extends StatelessWidget {
  final String name;
  final String rideId;

  CustomerDetails({
    required this.name,
    required this.rideId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 0.5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: textHeadingStyle),
            Text(rideId, style: textSubHeadingStyle),
          ],
        ),
      ],
    );
  }
}

const TextStyle textHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 14,
  fontWeight: FontWeight.w300,
  color: Color(0xFF000000),
);

const TextStyle textSubHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 12,
  fontWeight: FontWeight.w300,
  color: Color(0xFFECB21E),
);
