import 'package:dio/dio.dart';
import 'package:driver_app/service/start-ride/start-ride.dart';
import 'package:flutter/foundation.dart';



class StartShuttleState extends ChangeNotifier {
  final StartShuttleService _shuttleService = StartShuttleService();

  Future<void> startShuttleTracking(String driverLocation) async {
    try {
      Response response =
          await _shuttleService.startShuttleTracking(driverLocation);
      notifyListeners();
    } catch (error) {
      print('Error starting shuttle tracking: $error');
    }
  }

  Future<void> updateShuttleTracking(
      String trackingId, String driverCurrentLocation) async {
    try {
      Response response = await _shuttleService.updateShuttleTracking(
          trackingId, driverCurrentLocation);
       notifyListeners();
    } catch (error) {
      print('Error updating shuttle tracking: $error');
    }
  }
}
