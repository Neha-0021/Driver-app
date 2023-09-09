import 'package:dio/dio.dart';
import 'package:driver_app/service/History/history.dart';
import 'package:driver_app/state-management/next-stop.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CompleteRide extends StatelessWidget {
  CompleteRide({Key? key}) : super(key: key);
  final DriverHistoryService service = DriverHistoryService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AlertBundle alert = AlertBundle();
  Future<void> rideComplete(BuildContext context) async {
    final nextstopState =
        Provider.of<NextStoppageState>(context, listen: false);
    await nextstopState.getAllRoutes();

    if (nextstopState.routes.isNotEmpty) {
      for (var route in nextstopState.routes) {
        String routeId = route['_id'];
        String date = DateTime.now().toLocal().toString().split(' ')[0];
        Response response =
            await service.bulkUpdateBookingStatus(routeId, date);
        if (response.statusCode == 200) {
          print("Successfully complete the ride");
          if (_scaffoldKey.currentContext != null) {
            Navigator.of(_scaffoldKey.currentContext!).pop();
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: _scaffoldKey,
      child: Container(
        width: 320,
        height: 185,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Complete Ride?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'PublicaSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Are you sure you want to mark this ride completed? You will not be able to change it again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF75879B),
                  fontSize: 12,
                  fontFamily: 'PublicaSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
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
                                Navigator.of(context).pop();
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
                                rideComplete(context);
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
          ],
        ),
      ),
    );
  }
}
