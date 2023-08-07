import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

class StartShuttleService {
  final Dio _dio = Dio();
  final String _baseUrl = ServiceConfig.baseUrl;
  final PhoneStorage _storage = PhoneStorage();

  Future<Response<dynamic>> startShuttleTracking(String driverLocation) async {
    final String token = await _storage.getStringValue("token") ?? "";
    final Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      final response = await _dio.post(
        "$_baseUrl/api/driver/start-shuttle-tracking",
        data: {
          "driverLocation": driverLocation,
        },
        options: Options(headers: headers),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> updateShuttleTracking(
      String trackingId, String driverCurrentLocation) async {
    final String token = await _storage.getStringValue("token") ?? "";
    final Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      final response = await _dio.put(
        "$_baseUrl/api/driver/update-shuttle-tracking/$trackingId",
        data: {
          "driverCurrentLocation": driverCurrentLocation,
        },
        options: Options(headers: headers),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }
}
