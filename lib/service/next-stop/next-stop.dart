import 'package:dio/dio.dart';

class NextStoppageService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getNextStoppage(String driverId, String vehicleId) async {
    final url = 'http://127.0.0.1:8000/api/driver/get-next-stoppage/$driverId/$vehicleId';

    try {
      final response = await _dio.get(url);
      return response.data;
    } catch (error) {
      throw error;
    }
  }
}

