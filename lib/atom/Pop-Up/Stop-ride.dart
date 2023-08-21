import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/atom/custom-radioButton.dart';
import 'package:driver_app/service/stop-ride.dart';

class StopRide extends StatefulWidget {
 
  @override
  _StopRideState createState() => _StopRideState();
}

class _StopRideState extends State<StopRide> {
  StopRideService service = StopRideService();
  String error = '';

  bool isFirstReasonSelected = false;
  bool isSecondReasonSelected = false;

  void selectFirst() {
    setState(() {
      isFirstReasonSelected = true;
      isSecondReasonSelected = false;
    });
  }

  void selectSecond() {
    setState(() {
      isFirstReasonSelected = false;
      isSecondReasonSelected = true;
    });
  }

  void stopRide( context) async {
    try {
      String selectedReason = isFirstReasonSelected
          ? 'Vehicle Breakdown'
          : isSecondReasonSelected
              ? 'All users dropped'
              : ''; // You can add more logic if needed

      Response response = await service.stopRide(selectedReason);

      if (response.statusCode == 200) {
        // Handle success, e.g., show a success message or navigate somewhere
        Navigator.pop(context); // Close the dialog
      } else {
        setState(() {
          error = "Failed to stop ride";
        });
      }
    } catch (err) {
      setState(() {
        error = "An error occurred: $err";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: const ShapeDecoration(
                color: Color(0xFF485564),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/Star.png',
                      width: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Please tell us the reason:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'PublicaSans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomRadioButton(
              text: 'Vehicle Breakdown',
              isSelected: isFirstReasonSelected,
              onClick: selectFirst,
            ),
            CustomRadioButton(
              text: 'All users dropped',
              isSelected: isSecondReasonSelected,
              onClick: selectSecond,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(130, 41),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text(
                          'Go Back',
                          style: TextStyle(
                            fontFamily: 'PublicaSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF192B46),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          stopRide(context); 
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(130, 41),
                          backgroundColor: const Color(0xFF192B46),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          'Submit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                            fontFamily: 'PublicaSans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
