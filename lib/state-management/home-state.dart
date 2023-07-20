import 'package:dio/dio.dart';
import 'package:driver_app/service/login/login.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';

import 'package:driver_app/utils/storage.dart';

class HomeState extends ChangeNotifier {
  String driverId = "";
  String driverUsername = "";
  String driverPassword = "";

  DriverService driverService = DriverService();
  AlertBundle alert = AlertBundle();
  PhoneStorage storage = PhoneStorage();

  void updateDriverId(String id) {
    driverId = id;
    notifyListeners();
  }

  void updateDriverUsername(String username) {
    driverUsername = username;
    notifyListeners();
  }

  void updateDriverPassword(String password) {
    driverPassword = password;
    notifyListeners();
  }

  Future<dynamic> createDriverAccount() async {
    if (driverUsername.isNotEmpty && driverPassword.isNotEmpty) {
      Response response = await driverService.createDriver({
        "username": driverUsername,
        "password": driverPassword,
      });
      return {
        "code": response.statusCode,
        "message": response.data["message"],
      };
    } else {
      return {
        "code": 400,
        "message": "Please enter both username and password.",
      };
    }
  }

  Future<dynamic> driverLogin() async {
    if (driverUsername.isNotEmpty && driverPassword.isNotEmpty) {
      Response response = await driverService.driverLogin({
        "username": driverUsername,
        "password": driverPassword,
      });
      if (response.statusCode == 200) {
        if (response.data["token"] != "") {
          storage.setStringValue("token", response.data["token"]);
        }
      }
      return {
        "code": response.statusCode,
        "message": response.data["message"],
      };
    } else {
      return {
        "code": 400,
        "message": "Please enter both username and password.",
      };
    }
  }

  Future<dynamic> deleteDriverAccount() async {
    if (driverId.isNotEmpty) {
      Response response = await driverService.deleteDriver(driverId);
      return {
        "code": response.statusCode,
        "message": response.data["message"],
      };
    } else {
      return {
        "code": 400,
        "message": "Driver ID is required to delete the driver account.",
      };
    }
  }
}
