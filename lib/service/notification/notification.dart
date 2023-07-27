import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';


final dio = Dio();

class DriverNotificationService {
  String baseUrl = ServiceConfig.baseUrl;
  PhoneStorage storage = PhoneStorage();

  Future<Response<dynamic>> createDriverNotification() async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.post(
        "$baseUrl/api/driverNotification/create-driver-notification",
        data: {
          "title": "test",
          "description": "test",
          "notificationText": "test",
          "icon": "inserted",
          "isView": "N",
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

  Future<Response<dynamic>> getDriverNotification() async {
    try {
      final String token = await storage.getStringValue("token") ?? "";
      Map<String, dynamic> headers = {
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json',
      };
      return await dio.get(
        "$baseUrl/api/driverNotification/get-driver-notification",
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> getViewedDriverNotification() async {
    try {
      final String token = await storage.getStringValue("token") ?? "";
      Map<String, dynamic> headers = {
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json',
      };

      return await dio.get(
        "$baseUrl/api/driverNotification/get-viewed-driver-notification",
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> updateBulkDriverNotificationIsView(
      List<String> notificationIds) async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.put(
        "$baseUrl/api/driverNotification/bulk-update-driver-notification",
        data: {
          "ids": notificationIds,
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

  Future<Response<dynamic>> deleteDriverNotificationById(String id) async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.delete(
        "$baseUrl/api/driverNotification/delete-driver-notification/$id",
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteAllDriverNotification() async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.delete(
        "$baseUrl/api/driverNotification/delete-all-driver-notification",
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
