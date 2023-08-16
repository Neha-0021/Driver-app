import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';

class DriverRatingService {
  final Dio dio = Dio();
  final String baseUrl = ServiceConfig.baseUrl;

  Future<Response<dynamic>> driverRating(String bookingId, String rating) async {
    final Map<String, dynamic> data = {
      "bookingId": bookingId,
      "rating": rating,
    };

    try {
      return await dio.post(
        "$baseUrl/api/driver/driver-rating",
        data: data,
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> getDriverRatingByBookingId(String bookingId) async {
    try {
      return await dio.get(
        "$baseUrl/api/driver/get-driverRating-by-userId/$bookingId",
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteDriverRating(String ratingId) async {
    try {
      return await dio.delete(
        "$baseUrl/api/driver/delete-driver-rating/$ratingId",
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }
}

