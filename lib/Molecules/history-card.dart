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
                Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      data["route_details"]["image"],
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                        '${DateFormat("dd MMM yy").format(DateTime.parse(data['date']))} •${data["route_details"]["timing_form"]} to ${data["route_details"]["timing_to"]}',
                        style: textSubHeadingStyle,
                      ),
                    ],
                  ),
                ),
                HistoryStatus(
                  containerColor: data["isdelete"] == "N"
                      ? const Color(0xff00BD79)
                      : const Color(0xFFFF5353),
                  labelText: data["isdelete"] == "N"
                      ? "Completed"
                      : data["isdelete"] == "Y"
                          ? 'Cancelled'
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
