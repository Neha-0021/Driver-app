import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

final dio = Dio();

class DriverRatingService {
  String baseUrl = ServiceConfig.baseUrl;
PhoneStorage storage = PhoneStorage();

  Future<Response<dynamic>> DriverRating(String bookingId, String rating) async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.post(
        "$baseUrl/api/driver/driver-rating",
        data: {
          "bookingId": bookingId,
          "rating": rating,
        },
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> getDriverRatingByBookingId(String bookingId) async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.get(
        "$baseUrl/api/driver/get-driverRating-by-userId/$bookingId",
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteDriverRating(String ratingId) async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.delete(
        "$baseUrl/api/driver/delete-driver-rating/$ratingId",
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
