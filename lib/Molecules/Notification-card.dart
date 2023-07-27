import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const NotificationCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(6, 6),
            blurRadius: 24,
            spreadRadius: -13,
            color: Color(0xFF000000).withOpacity(0.4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/history.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: 'Your bus route',
                            style: textHeadingStyle.copyWith(
                              decoration: TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' is from Ahmedabad to Kanpur. Stay tuned for more updates!',
                            style: textSubHeadingStyle.copyWith(
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '09:30 AM • Fri, 19 May',
                      style: textSubHeadingStyle.copyWith(
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const TextStyle textHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Color(0xFF000000),
);
const TextStyle textSubHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Color(0xFF75879B),
);
