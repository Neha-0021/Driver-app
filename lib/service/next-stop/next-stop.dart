import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';

final dio = Dio();

class NextStoppageService {
  String baseUrl = ServiceConfig.baseUrl;
  PhoneStorage storage = PhoneStorage();

  Future<Response<dynamic>> getNextStoppage(
      String routeId, String stoppageId) async {
    try {
      final String token = await storage.getStringValue("token") ?? "";
      Map<String, dynamic> headers = {
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json',
      };

      final response = await dio.get(
        "$baseUrl/api/driver/get-next-stoppage/$routeId/$stoppageId",
        options: Options(headers: headers),
      );

      return response;
    } catch (err) {
      if (err is DioException) {
        print('DioException: ${err.message}');
        return err.response!;
      }
      rethrow;
    }
  }

  getAllRoutes() async {
    try {
      Response response = await dio.get(
        "$baseUrl/api/core/get-all-route",
      );
      return response;
    } catch (err) {
      print(err);
      if (err is DioException) {
        return (err.response);
      }
    }
  }
  getStoppagesByRouteId(String routeId) async {
    try {
      Response response = await dio.get(
        "$baseUrl/api/core/get-stoppage-by-routeID/$routeId",
      );
      return response;
    } catch (err) {
      print(err);
      if (err is DioException) {
        return (err.response);
      }
    }
  }
}
