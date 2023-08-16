import 'package:dio/dio.dart';
import 'package:driver_app/service/common.dart';
import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';


class ProfileState extends ChangeNotifier {
  final ProfileService service = ProfileService();
   CommonService common = CommonService();
  AlertBundle alert = AlertBundle();
   bool isDisableText = true;

  Map<String, dynamic> driver = {};

  String profileImagePath = "";

   void updateProfileImage(image) {
    profileImagePath = image.path;
    notifyListeners();
  }

   void updateState(String key, dynamic value) {
    driver[key] = value;
    notifyListeners();
  }

   void toggleEdit() {
    isDisableText = !isDisableText;
    notifyListeners();
  }

  


  Future<void> getDriverProfile() async {
    try {
      final response = await service.getDriverProfile();
      driver = response.data; 
      notifyListeners();
    } catch (error) {
      print('Error fetching driver profile: $error');
    }
  }

  void submit(context) async {
    if (profileImagePath != "") {
      await uploadFileAndGetLink(context);
    }
    Response callback = await service.getDriverProfile();
    if (callback.statusCode == 200) {
      alert.SnackBarNotify(context, "Profile Updated");
      isDisableText = !isDisableText;
    } else {
      alert.SnackBarNotify(
          context, "Unable to update profile please try again.");
    }
    notifyListeners();
  }

  uploadFileAndGetLink(context) async {
    var sendingData = FormData.fromMap({
      'file': await MultipartFile.fromFile(profileImagePath),
    });
    Response fileCallback = await common.uploadFile(sendingData);
    if (fileCallback.statusCode == 200) {
      driver["profile_photo"] = fileCallback.data["result"];
      notifyListeners();
      alert.SnackBarNotify(context, "profile photo Updated");
    } else {
      alert.SnackBarNotify(
          context, "Oops error while uploading your profile photo.");
    }
  }
}
