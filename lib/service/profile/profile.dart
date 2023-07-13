import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';


final dio = Dio();

class ProfileService {
  String baseUrl = ServiceConfig.baseUrl;

  PhoneStorage storage = PhoneStorage();

  getUserProfile(data) async {
    String? token = await storage.getStringValue("token");
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      Response response = await dio.get("$baseUrl/api/user/get-user",
          options: Options(headers: headers));
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  saveUserDetails(data) async {
    String? token = await storage.getStringValue("token");
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };
    try {
      Response response = await dio.put("$baseUrl/api/user/edit-profile",
          options: Options(headers: headers), data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }


}