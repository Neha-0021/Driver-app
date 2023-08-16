import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

class ShuttleTrackingService {
  final Dio dio = Dio();
  final String baseUrl = ServiceConfig.baseUrl;
  final PhoneStorage storage = PhoneStorage();

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
