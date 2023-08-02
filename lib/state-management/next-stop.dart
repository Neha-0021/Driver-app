import 'package:driver_app/service/next-stop/next-stop.dart';
import 'package:flutter/material.dart';


class NextStoppageState extends ChangeNotifier {
  final NextStoppageService service = NextStoppageService();

  Map<String, dynamic> nextStoppageData = {};

  Future<void> getNextStoppageData(String driverId, String vehicleId) async {
    try {
      nextStoppageData = await service.getNextStoppage(driverId, vehicleId);
      notifyListeners();
    } catch (error) {
      print('Error fetching next stoppage data: $error');
    }
  }
}
