import 'package:dio/dio.dart';
import 'package:driver_app/service/login/login.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';

import 'package:driver_app/utils/storage.dart';

class DriverRatingState extends ChangeNotifier {

 List<dynamic> driverRating = [];

  DriverService driverService = DriverService();
  AlertBundle alert = AlertBundle();
  PhoneStorage storage = PhoneStorage();

  void DriverRating(String rating) {
    driverRating = ['rating'];
    notifyListeners();
  }

  void DeleteDriverRating(String rating) {
    driverRating = ['rating'];
    notifyListeners();
  }

  Future<void> rateDriver(String driverId, int rating) async {
    try {
      Response response = await driverService.rateDriver(driverId, rating);
    } catch (error) {
      print('Error rating driver: $error');
    }
  }

  Future<void> deleteDriverRating(String driverId) async {
    try {
      Response response = await driverService.deleteDriverRating(driverId);
    } catch (error) {
      print('Error deleting driver rating: $error');
    }
  }
}
