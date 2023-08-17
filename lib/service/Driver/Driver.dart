import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';

class DriverRatingService {
  final Dio dio = Dio();
  final String baseUrl = ServiceConfig.baseUrl;

  Future<Response> driverRating(String bookingId, int rating) async {
    final Map<String, dynamic> data = {
      "bookingId": bookingId,
      "rating": rating.toString(),
    };

    try {
      final response = await dio.post(
        "$baseUrl/api/driver/driver-rating",
        data: data,
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response> deleteDriverRating(String ratingId) async {
    try {
      final response = await dio.delete(
        "$baseUrl/api/driver/delete-driver-rating/$ratingId",
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response> getDriverRatingByBookingId(String bookingId) async {
  try {
    final response = await dio.get(
      "$baseUrl/api/driver/get-driverRating/$bookingId",
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
