import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

final dio = Dio();

class  DriverHistoryService {
  String baseUrl = ServiceConfig.baseUrl;
  PhoneStorage storage = PhoneStorage();

  Future<Response> getDriverUpcomingBookings() async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.get(
        "$baseUrl/api/driver/get-driver-upcomming-booking",
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response> getDriverCompleteHistory() async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.get(
        "$baseUrl/api/driver/get-driver-complete-history",
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response> bulkUpdateBookingStatus(
      String routeId, String date) async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.put(
        "$baseUrl/api/driver/bulk-update-booking-status/$routeId/$date",
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }
}
