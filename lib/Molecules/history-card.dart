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
    bool isVehicleBreakdown = data["reason"] == "Vehicle Breakdown";
    bool isAllUsersDropped = data["reason"] == "All users dropped";

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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    data["routeDetails"][0]["image"],
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data["routeDetails"][0]["route_name"]}",
                              style: textHeadingstyle,
                            ),
                            Text(
                              '${DateFormat("dd MMM yy").format(DateTime.parse(data['date']))}•${data["routeDetails"][0]["timing_form"]} - ${data["routeDetails"][0]["timing_to"]}',
                              style: textSubHeadingStyle,
                            ),
                          ],
                        ),
                      ),
                      HistoryStatus(
                        containerColor: isVehicleBreakdown
                            ? const Color(0xFFF9A90C)
                            : isAllUsersDropped
                                ? const Color(0xff00BD79)
                                : Colors
                                    .black, // Adjust as needed for other cases
                        labelText: isVehicleBreakdown
                            ? "Stopped"
                            : isAllUsersDropped
                                ? "Completed"
                                : "", // Adjust as needed for other cases
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
