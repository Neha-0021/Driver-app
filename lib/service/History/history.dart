import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';

final dio = Dio();

class DriverHistoryService {
  String baseUrl = ServiceConfig.baseUrl;

  Future<Response> getDriverUpcomingBookings() async {
    try {
      Response response = await dio.get("$baseUrl/api/driver/get-driver-upcomming-booking");
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      throw err;
    }
  }

  Future<Response> getDriverCompleteHistory() async {
    try {
      Response response = await dio.get("$baseUrl/api/driver/get-driver-complete-history");
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      throw err;
    }
  }

  Future<Response> bulkUpdateBookingStatus(String driverId) async {
    try {
      Response response = await dio.put("$baseUrl/api/driver/bulk-update-booking-status/$driverId");
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      throw err;
    }
  }
}
