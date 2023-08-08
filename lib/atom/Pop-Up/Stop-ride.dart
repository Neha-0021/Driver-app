import 'package:driver_app/atom/custom-radioButton.dart';
import 'package:driver_app/state-management/stop-ride.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StopRide extends StatefulWidget {
  const StopRide({super.key});

  @override
  _StopRideState createState() => _StopRideState();
}

class _StopRideState extends State<StopRide> {
  bool isFirstSelected = false;
  bool isSecondSelected = false;

  void selectFirst() {
    setState(() {
      isFirstSelected = true;
      isSecondSelected = false;
    });
  }

  void selectSecond() {
    setState(() {
      isFirstSelected = false;
      isSecondSelected = true;
    });
  }

  Future<void> submitStopRide() async {
    String reason = isFirstSelected ? 'Vehicle Breakdown' : 'All users dropped';
    final StopState = Provider.of<StopRideState>(context, listen: false);
    StopState.stopRide(reason);
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
              isSelected: isFirstSelected,
              onClick: selectFirst,
            ),
            CustomRadioButton(
              text: 'All users dropped',
              isSelected: isSecondSelected,
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
                          Navigator.pop(context);
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
                        onPressed: submitStopRide,
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
