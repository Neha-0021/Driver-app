import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

final dio = Dio();

class DriverService {
  String baseUrl = ServiceConfig.baseUrl;
  PhoneStorage storage = PhoneStorage();

  Future<Response> rateDriver(String bookingId, String rating) async {
    try {
      Map<String, dynamic> body = {
        'bookingId': bookingId,
        'rating': rating,
      };

      Response response = await dio.post("$baseUrl/api/driver/driver-rating",
          data: body,
          options: Options(contentType: Headers.jsonContentType));
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      throw err;
    }
  }

  Future<Response> deleteDriverRating(String driverRatingId) async {
    try {
      Response response = await dio.delete(
        "$baseUrl/api/driver/delete-driver-rating/$driverRatingId",
      );
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      throw err;
    }
  }
}
