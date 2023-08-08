import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

final dio = Dio();

class StopRideService {
  String baseUrl = ServiceConfig.baseUrl;

  PhoneStorage storage = PhoneStorage();

  Future<Response> stopRide(String reason) async {
    String? token = await storage.getStringValue("token");
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      "reason": reason,
    };

    try {
      Response response = await dio.post(
        "$baseUrl/api/driver/stop-ride",
        data: requestBody,
        options: Options(headers: headers),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      throw err;
    }
  }
}
