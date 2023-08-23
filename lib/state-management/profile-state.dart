import 'package:dio/dio.dart';
import 'package:driver_app/service/common.dart';

import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';

class ProfileState extends ChangeNotifier {
  final ProfileService service = ProfileService();
  CommonService common = CommonService();
  AlertBundle alert = AlertBundle();

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

  uploadFileAndGetLink(context, image) async {
    debugPrint(image.path);
    var sendingData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path),
    });

    Response fileCallback = await common.uploadFile(sendingData);
    debugPrint(fileCallback.data.toString());
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
