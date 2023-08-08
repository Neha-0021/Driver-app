import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';

final dio = Dio();

class NextStoppageService {
  String baseUrl = ServiceConfig.baseUrl;

  Future<Response> getNextStoppage(String driverId, String stoppageId) async {
    try {
      final response = await dio.get("$baseUrl/api/driver/get-next-stoppage/$driverId/$stoppageId");
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      throw err;
    }
  }
}
