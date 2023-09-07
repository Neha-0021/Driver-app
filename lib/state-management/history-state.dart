import 'package:dio/dio.dart';
import 'package:driver_app/service/History/history.dart';
import 'package:flutter/foundation.dart';

class DriverHistoryState extends ChangeNotifier {
  final DriverHistoryService historyService = DriverHistoryService();

  List<dynamic> upcomingBookings = [];
  List<dynamic> completeHistory = [];

  Future<void> getDriverUpcomingBookings() async {
    try {
      Response response = await historyService.getDriverUpcomingBookings();
      upcomingBookings = response.data;
      notifyListeners();
    } catch (error) {
      print('Error fetching upcoming bookings: $error');
    }
  }

  Future<void> getDriverCompleteHistory() async {
    try {
      Response response = await historyService.getDriverCompleteHistory();
      completeHistory = response.data["bookings"].reversed.toList();

      List<String> ids = response.data["bookings"]
          .map<String>((obj) => obj["_id"].toString())
          .toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }

  
}
