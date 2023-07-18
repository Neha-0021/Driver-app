import 'package:dio/dio.dart';
import 'package:driver_app/service/login/login.dart';
import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:driver_app/utils/storage.dart';
import 'package:flutter/material.dart';


class HomeState extends ChangeNotifier {
  String phone = "";
  String messageId = "";
  String otp = "";
  String userEnteredOTP = "";
  bool timer = false;
  Map<String, dynamic> saveUserdetails = {
    "_id": "",
    "firstname": "",
    "lastname": "",
    "email": "",
    "address": "",
    "workplaceId": "",
    "mobile": "",
    "password": "",
    "isactive": "Y",
    "isdelete": "N",
    "isblocked": "N",
    "isVerify": "Y",
    "createdOn": "",
    "updatedOn": "",
    "referral_code": "",
    "referred_by": ""
  };

  // ignore: non_constant_identifier_names
  Map<String, String> Login = {
    "username": "9691465201",
    "password": "1111",
  };

  bool resetMpin = false;

  Map<String, String> userDetails = {
    "mpin": "",
    "confirmMpin": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "referCode": "",
    "officeTimeFrom": "",
    "officeTimeTo": "",
    "officeFrom": "",
    "officeTo": ""
  };

  LoginService service = LoginService();
  ProfileService profileService = ProfileService();
  AlertBundle alert = AlertBundle();
  PhoneStorage storage = PhoneStorage();
 

  void updatePhone(data) {
    phone = data;
    notifyListeners();
  }

  void setUserOTP(data) {
    userEnteredOTP = data;
    notifyListeners();
  }

  void timerOver() {
    timer = true;
    notifyListeners();
  }

  void updateValue(String key, String value) {
    userDetails[key] = value;
    notifyListeners();
  }

  void updateLoginValue(String key, String value) {
    Login[key] = value;
    notifyListeners();
  }

  void updateMessageId(String value) {
    messageId = value;
    notifyListeners();
  }

  void reset() {
    Login = {
      "username": "",
      "password": "",
    };
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> CheckUser() async {
    if (phone != "") {
      Response userCallBack = await service.checkUserEnroll({"mobile": phone});
      if (userCallBack.statusCode == 400) {
        return {
          "code": 200,
          "message":
              "We have sent you verification code please enter to continue."
        };
      } else {
        return {
          "code": 400,
          "message": "We have found an account with this number please login"
        };
      }
    }
    return {"code": 400, "message": "Please enter number to continue"};
  }

  Future<dynamic> validateOTPAPI() async {
    if (!timer) {
      // ignore: non_constant_identifier_names
      Response OTPValidationCallback = await service
          .validateOTP({"otp": userEnteredOTP, "messageId": messageId});

      if (OTPValidationCallback.statusCode == 200) {
        return {"code": 200, "message": OTPValidationCallback.data["message"]};
      } else {
        return {"code": 400, "message": OTPValidationCallback.data["message"]};
      }
    } else {
      return {"code": 400, "message": "Time over Please retry"};
    }
  }

  Future<dynamic> sendOTP() async {
    if (phone != "") {
      Response otpSentResponse = await service.sendOTPAPI({
        "mobile": phone,
      });
      if (otpSentResponse.statusCode == 200) {
        updateMessageId(otpSentResponse.data["messageId"]);
        return {"code": 200, "message": otpSentResponse.data["message"]};
      } else {
        return {"code": 400, "message": otpSentResponse.data["message"]};
      }
    } else {
      return {
        "code": 400,
        "message": "Phone Number not found please try again."
      };
    }
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> CreateUserAccount() async {
    if (userDetails['mpin'] == userDetails['confirmMpin']) {
      // ignore: non_constant_identifier_names
      Response UserCreatedCallBack = await service.createUser({
        "firstname": userDetails["firstName"],
        "lastname": userDetails["lastName"],
        "email": userDetails["email"],
        "address": userDetails["officeFrom"],
        "workplace": userDetails["officeTo"],
        "mobile": int.parse(phone),
        "password": userDetails["mpin"],
        "isactive": "Y",
        "isVerify": "Y",
        "referred_by": userDetails["referCode"],
        "officeTimeFrom": userDetails['officeTimeFrom'],
        "officeTimeTo": userDetails['officeTimeTo'],
        "profile_photo":
            "https://rydthru.s3.amazonaws.com/blank-profile-picture-973460_1280.webp"
      });
      if (UserCreatedCallBack.statusCode == 200) {
    
        return {"code": 200, "message": UserCreatedCallBack.data["message"]};
      } else {
        return {"code": 400, "message": UserCreatedCallBack.data["message"]};
      }
    }
  }

  Future<dynamic> loginUser() async {
    // this need to be done via phone
    Response loginAPICallback = await service
        .login({"mobile": Login["username"], "password": Login["password"]});
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

  Future<dynamic> getUserProfile() async {
    Response getUserDetailsAPIcallBack =
        await profileService.getUserProfile({});
    if (getUserDetailsAPIcallBack.statusCode == 200) {
      saveUserdetails = getUserDetailsAPIcallBack.data["user"];
      notifyListeners();
      return {"code": 200, "message": "failed to get user details."};
    } else {
      return {"code": 400, "message": "failed to get user details."};
    }
  }
}