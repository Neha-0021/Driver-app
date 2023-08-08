import 'package:driver_app/service/stop-ride.dart';
import 'package:flutter/material.dart';

class StopRideState extends ChangeNotifier {
  final StopRideService service = StopRideService();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> stopRide(String reason) async {
    isLoading = true;
    errorMessage = '';

    try {
      final response = await service.stopRide(reason);
      if (response.statusCode == 200) {
      } else {
        errorMessage = "Failed to stop ride";
      }
    } catch (error) {
      errorMessage = "An error occurred: $error";
    }

    isLoading = false;
    notifyListeners();
  }
}
