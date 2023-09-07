import 'package:driver_app/atom/history-status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data["stoppage_from_details"]["stoppage_name"]} - ${data["stoppage_to_details"]["stoppage_name"]}",
                        style: textHeadingstyle,
                      ),
                      Text(
                        '${DateFormat("dd MMM yy").format(DateTime.parse(data['date']))}',
                        style: textSubHeadingStyle,
                      ),
                    ],
                  ),
                ),
                HistoryStatus(
                  containerColor: data["iscomplete"] == "Y"
                      ? const Color(0xff00BD79)
                      : const Color(0xFFF9A90C),
                  labelText: data["iscomplete"] == "Y"
                      ? "Completed"
                      : data["iscomplete"] == "N"
                          ? 'stopped'
                          : "",
                ),
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
