import 'package:driver_app/atom/history-status.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const HistoryCard({
    super.key,
    required this.data,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 12,
                spreadRadius: -2,
                color: Color(0xFF000000).withOpacity(0.4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.asset(
                      'assets/images/history.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Route Name',
                        style: textHeadingstyle,
                      ),
                      Text(
                        'Sun 14 May • 08:30 AM to 03:30 PM',
                        style: textSubHeadingStyle,
                      ),
                    ],
                  ),
                ),
                HistoryStatus(
                    containerColor: const Color(0xFF00BD79),
                    labelText: 'Completed')
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const TextStyle textHeadingstyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Color(0xFF000000),
);

const TextStyle textSubHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: Color(0xFF75879B),
);
