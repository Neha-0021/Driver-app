import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';

final dio = Dio();

class RouteDetailService {
  String baseUrl = ServiceConfig.baseUrl;

  Future<Response> getRouteDetailsByDriver() async {
    try {
      final response = await dio.get("$baseUrl/api/driver/route_detail_by_driver/2023-07-26");
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      throw err;
    }
  }
}
