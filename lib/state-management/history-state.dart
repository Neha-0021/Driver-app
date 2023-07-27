import 'package:driver_app/service/History/history.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DriverHistoryState extends ChangeNotifier {
  List<dynamic> upcomingBookings = [];
  List<dynamic> completeHistory = [];

  DriverHistoryService driverService = DriverHistoryService();

  Future<void> fetchDriverUpcomingBookings() async {
    try {
      Response response = await driverService.getDriverUpcomingBookings();
      upcomingBookings = response.data;
      notifyListeners();
    } catch (error) {
      print('Error fetching upcoming bookings: $error');
    }
  }

  Future<void> fetchDriverCompleteHistory() async {
    try {
      Response response = await driverService.getDriverCompleteHistory();
      completeHistory = response.data;
      notifyListeners();
    } catch (error) {
      print('Error fetching complete history: $error');
    }
  }

  Future<void> bulkUpdateBookingStatus(String driverId) async {
    try {
      Response response = await driverService.bulkUpdateBookingStatus(driverId);
    } catch (error) {
      print('Error updating booking status: $error');
    }
  }
}
