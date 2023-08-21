import 'package:dio/dio.dart';
import 'package:driver_app/service/start-ride/start-ride.dart';
import 'package:flutter/foundation.dart';

class ShuttleTrackingState extends ChangeNotifier {
  final ShuttleTrackingService service = ShuttleTrackingService();

  Map<String, dynamic> data = {};

  Future<void> startShuttleTracking(
      double driverLatitude, double driverLongitude) async {
    try {
      Response response = await service.startShuttleTracking(driverLatitude, driverLongitude);
      data = Map<String, dynamic>.from(response.data["data"]);
      notifyListeners();
    } catch (error) {
      print('Error starting shuttle tracking: $error');
    }
  }

  Future<void> updateShuttleTracking(
      String id, String driverCurrentLocation) async {
    try {
      await service.updateShuttleTracking(id, driverCurrentLocation);

      notifyListeners();
    } catch (error) {
      print('Error updating shuttle tracking: $error');
    }
  }
}
