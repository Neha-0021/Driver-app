import 'package:dio/dio.dart';
import 'package:driver_app/service/common.dart';
import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';


class ProfileState extends ChangeNotifier {
  ProfileService service = ProfileService();
  CommonService common = CommonService();
  AlertBundle alert = AlertBundle();

  Map<String, dynamic> userData = {};

  String profileImagePath = "";

  bool isDisableText = true;

  void updateProfileImage(image) {
    profileImagePath = image.path;
    notifyListeners();
  }

  void getUser() async {
    print("inside get user");
    Response userDetails = await service.getUserProfile({});
    userData = userDetails.data["user"];
    notifyListeners();
  }

  void updateState(String key, dynamic value) {
    userData[key] = value;
    notifyListeners();
    print(userData);
  }

  void toggleEdit() {
    isDisableText = !isDisableText;
    notifyListeners();
  }

  void submit(context) async {
    if(profileImagePath!=""){
    await uploadFileAndGetLink(context);
    }
    Response callback = await service.saveUserDetails(userData);
    if (callback.statusCode == 200) {
      alert.SnackBarNotify(context, "Profile Updated");
    } else {
      alert.SnackBarNotify(
          context, "Unable to update profile please try again.");
    }
  }

  uploadFileAndGetLink(context) async {
    var sendingData = FormData.fromMap({
      'file': await MultipartFile.fromFile(profileImagePath),
    });
    Response fileCallback = await common.uploadFile(sendingData);
    if (fileCallback.statusCode == 200) {
      userData["profile_photo"] = fileCallback.data["result"];
      notifyListeners();
      alert.SnackBarNotify(context, "profile photo Updated");
    } else {
      alert.SnackBarNotify(context, "Oops error while uploading your profile photo.");
    }
  }
}