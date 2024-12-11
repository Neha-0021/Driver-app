import 'package:dio/dio.dart';
import 'package:driver_app/notification-handler.dart';
import 'package:driver_app/service/login/login.dart';
import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/utils/storage.dart';

class HomeState extends ChangeNotifier {
  String driverMobile = "";
  String driverPassword = "";
  String mobileErrorText = "";
  String loginErrorText = "";
  Map<String, dynamic> driverData = {};

  Map<String, dynamic> Login = {
    "userName": "",
    "password": "",
    "fcmToken": "",
  };

  DriverService services = DriverService();
  AlertBundle alert = AlertBundle();
  PhoneStorage storage = PhoneStorage();
  ProfileService profileService = ProfileService();

  void updateDriverMobile(String userName) {
    driverMobile = userName;
    notifyListeners();
  }

  void updateDriverPassword(String password) {
    driverPassword = password;
    notifyListeners();
  }

  void setLoginErrorText(val) {
    loginErrorText = val;
    notifyListeners();
  }

  void updateLoginValue(String key, String value) {
    Login[key] = value;
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

  Future<dynamic> loginDriver() async {
    // this need to be done via phone
    String fcmToken = await NotificationHandler().getFcmToken();
    Login["fcmToken"] = fcmToken;
    Response loginAPICallback = await services.driverLogin({
      "userName": Login["userName"],
      "password": Login["password"],
      "fcmToken": Login["fcmToken"]
    });
    if (loginAPICallback.statusCode == 200) {
      if (loginAPICallback.data["token"] != "") {
        storage.setStringValue("token", loginAPICallback.data["token"]);
      }
    }
    return {
      "code": loginAPICallback.statusCode,
      "message": loginAPICallback.data["message"],
    };
  }

  Future<dynamic> getDriverProfile() async {
    Response getDriverDetailsAPIcallBack =
        await profileService.getDriverProfile();
    if (getDriverDetailsAPIcallBack.statusCode == 200) {
      driverData = getDriverDetailsAPIcallBack.data["driver"];
      notifyListeners();
      return {"code": 200, "message": "failed to get driver details."};
    } else {
      return {"code": 400, "message": "failed to get driver details."};
    }
  }
}
