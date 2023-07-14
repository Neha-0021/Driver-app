import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';


final dio = Dio();

class LoginService {
  String baseUrl = ServiceConfig.baseUrl;

  checkUserEnroll(data) async {
    try {
      Response response =
          await dio.post("$baseUrl/api/user/check-user-by-mobile", data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  validateOTP(data) async {
    try {
      Response response = await dio.post(
        "$baseUrl/api/user/otp-verification",
        data: data,
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  sendOTPAPI(data) async {
    try {
      Response response =
          await dio.post("$baseUrl/api/user/send-otp-by-mobile", data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  createUser(data) async {
    try {
      Response response =
          await dio.post("$baseUrl/api/user/createUser", data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  login(data) async {
    try {
      Response response = await dio.post("$baseUrl/api/user/login", data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  forgetMpin(data) async {
    try {
      Response response =
          await dio.post("$baseUrl/api/user/forget-password", data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }
}