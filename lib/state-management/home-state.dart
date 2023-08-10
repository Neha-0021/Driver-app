import 'package:dio/dio.dart';
import 'package:driver_app/service/login/login.dart';
import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/utils/storage.dart';

class HomeState extends ChangeNotifier {
  String driverId = "";
  String driverMobile = "";
  String driverPassword = "";
  Map<String, dynamic> saveDriverDetails = {
    "_id": "",
    "firstname": "",
    "lastname": "",
    "email": "",
    "mobile": "",
    "password": "",
  };

  DriverService driverService = DriverService();
  AlertBundle alert = AlertBundle();
  PhoneStorage storage = PhoneStorage();
  ProfileService profileService = ProfileService();

  void updateDriverId(String id) {
    driverId = id;
    notifyListeners();
  }

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
      Response response = await driverService.createDriver({
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

    Response response = await driverService.driverLogin({
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

 Future<dynamic> deleteDriverAccount() async {
    if (driverId.isEmpty) {
      return {
        "code": 400,
        "message": "Driver ID is required to delete the driver account.",
      };
    }

    Response response = await driverService.deleteDriver(driverId);
    return {
      "code": response.statusCode,
      "message": response.data["message"],
    };
  }

  Future<dynamic> getDriverProfile() async {
    Response getDriverDetailsAPIcallBack =
        await profileService.getDriverProfile({});
    if (getDriverDetailsAPIcallBack.statusCode == 200) {
      saveDriverDetails = getDriverDetailsAPIcallBack.data["driver"];
      notifyListeners();
      return {"code": 200, "message": "failed to get user details."};
    } else {
      return {"code": 400, "message": "failed to get user details."};
    }
  }
}