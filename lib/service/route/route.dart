import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

final dio = Dio();

class RouteDetailService {
  String baseUrl = ServiceConfig.baseUrl;

  PhoneStorage storage = PhoneStorage();
  getRouteDetailsByDriver() async {
    String? token = await storage.getStringValue("token");
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      Response response = await dio.get(
          "$baseUrl/api/driver/route_detail_by_driver/2023-07-26",
          options: Options(headers: headers));
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }
}