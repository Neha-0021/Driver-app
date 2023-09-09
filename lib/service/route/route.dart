import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

final dio = Dio();

class RouteDetailService {
  String baseUrl = ServiceConfig.baseUrl;

  PhoneStorage storage = PhoneStorage();
  getRouteDetailsByDriver(String date) async {
    String? token = await storage.getStringValue("token");
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      Response response = await dio.get(
          "$baseUrl/api/driver/route_detail_by_driver/$date",
          options: Options(headers: headers));
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

   Future<Response<dynamic>> startShuttleTracking(
      double driverLatitude, double driverLongitude) async {
   String? token = await storage.getStringValue("token");
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = {
      'driverLatitude': driverLatitude.toString(),
      'driverLongitude': driverLongitude.toString(),
    };

    try {
      return await dio.post(
        '$baseUrl/api/driver/start-shuttle-tracking',
        data: body,
        options: Options(headers: headers),
      );
    } catch (error) {
      throw error;
    }
  }

  Future<Response<dynamic>> updateShuttleTracking(
      String id, String driverCurrentLocation) async {
    final String token = await storage.getStringValue('token') ?? '';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = {
      'driverCurrentLocation': driverCurrentLocation,
    };

    try {
      return await dio.put(
        '$baseUrl/api/driver/update-shuttle-tracking/$id',
        data: body,
        options: Options(headers: headers),
      );
    } catch (error) {
      throw error;
    }
  }
}
