import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';

final dio = Dio();

class DriverService {
  String baseUrl = ServiceConfig.baseUrl;

  createDriver(data) async {
    try {
      Response response =
          await dio.post("$baseUrl/api/driver/create-driver", data: data);
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  driverLogin(data) async {
    try {
      Response response = await dio.post(
        "$baseUrl/api/driver/driver-login",
        data: data,
      );
      return response;
    } catch (err) {
      print(err);
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  deleteDriver(driverId) async {
    try {
      Response response = await dio.delete(
        "$baseUrl/api/driver/delete-driver/$driverId",
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  updateDriver(driverId, data) async {
    try {
      Response response = await dio.put(
        "$baseUrl/api/driver/update-driver/$driverId",
        data: data,
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }

  deleteAllDrivers() async {
    try {
      Response response = await dio.delete(
        "$baseUrl/api/driver/delete-all-driver",
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return (err.response);
      }
    }
  }
}
