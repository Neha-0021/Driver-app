import 'package:driver_app/service/start-ride/start-ride.dart';
import 'package:flutter/foundation.dart';

class ShuttleTrackingState extends ChangeNotifier {
  final ShuttleTrackingService _service = ShuttleTrackingService();

  Future<void> startShuttleTracking(
      double driverLatitude, double driverLongitude) async {
    try {
      await _service.startShuttleTracking(driverLatitude, driverLongitude);

      notifyListeners();
    } catch (error) {
      print('Error starting shuttle tracking: $error');
    }
  }

  Future<void> updateShuttleTracking(
      String id, String driverCurrentLocation) async {
    try {
      await _service.updateShuttleTracking(id, driverCurrentLocation);

      notifyListeners();
    } catch (error) {
      print('Error updating shuttle tracking: $error');
    }
  }
}
