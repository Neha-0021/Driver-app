import 'package:dio/dio.dart';
import 'package:driver_app/service/login/login.dart';
import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/utils/storage.dart';

class HomeState extends ChangeNotifier {
  String driverMobile = "";
  String driverPassword = "";

  DriverService services = DriverService();
  AlertBundle alert = AlertBundle();
  PhoneStorage storage = PhoneStorage();
  ProfileService profileService = ProfileService();

  void updateDriverMobile(String mobile) {
    driverMobile = mobile;
    notifyListeners();
  }

  void updateDriverPassword(String password) {
    driverPassword = password;
    notifyListeners();
  }

  Future<dynamic> createDriverAccount() async {
    if (driverMobile.isNotEmpty && driverPassword.isNotEmpty) {
      Response response = await services.createDriver({
        "username": driverMobile,
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
    if (driverMobile.isEmpty || driverPassword.isEmpty) {
      return {
        "code": 400,
        "message": "Please enter both username and password.",
      };
    }

    Response response = await services.driverLogin({
      "mobile": driverMobile,
      "password": driverPassword,
    });

    if (response.statusCode == 200) {
      String token = response.data["token"];
      if (token != "") {
        storage.setStringValue("token", token);
        return {
          "code": 200,
          "message": "Login successful.",
        };
      } else {
        return {
          "code": 400,
          "message": "Invalid token received from the server.",
        };
      }
    } else {
      return {
        "code": response.statusCode,
        "message": response.data["message"],
      };
    }
  }
}
