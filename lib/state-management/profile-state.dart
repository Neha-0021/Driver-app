import 'package:dio/dio.dart';
import 'package:driver_app/service/common.dart';
import 'package:driver_app/service/login/login.dart';

import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileState extends ChangeNotifier {
  final ProfileService service = ProfileService();
  CommonService common = CommonService();
  AlertBundle alert = AlertBundle();
  DriverService services = DriverService();

  Map<String, dynamic> driverData = {};

  String profileImagePath = "";

  void updateProfileImage(image) async {
    profileImagePath = image.path;
    notifyListeners();
  }

  void getDriver() async {
    Response driverDetails = await service.getDriverProfile();
    driverData = driverDetails.data["driver"];
    notifyListeners();
  }

  void update(context) async {
    if (profileImagePath != "") {
      await uploadFileAndGetLink(context);
    }
    final stateCall = Provider.of<ProfileState>(context, listen: false);
    String driverId = stateCall.driverData["_id"];
    Response callback = await services.updateDriver(driverId, driverData);
    if (callback.statusCode == 200) {
      alert.SnackBarNotify(context, "Profile Updated");
    } else {
      alert.SnackBarNotify(
          context, "Unable to update profile please try again.");
    }
    notifyListeners();
  }

  uploadFileAndGetLink(context) async {
    debugPrint(profileImagePath);
    var sendingData = FormData.fromMap({
      'file': await MultipartFile.fromFile(profileImagePath),
    });
    Response fileCallback = await common.uploadFile(sendingData);
    if (fileCallback.statusCode == 200) {
      driverData["profile_photo"] = fileCallback.data["result"];
      notifyListeners();
      alert.SnackBarNotify(context, "profile photo Updated");
    } else {
      alert.SnackBarNotify(
          context, "Oops error while uploading your profile photo.");
    }
  }
}
