import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';


final dio = Dio();

class NotificationService {
  String baseUrl = ServiceConfig.baseUrl;
  PhoneStorage storage = PhoneStorage();

  Future<Response<dynamic>> createNotification(String s) async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.post(
        "$baseUrl/api/notification/create-notification",
        data: {
          "notificationText": "Test notification",
          "icon": "inserted",
          "createdAt": "",
          "isView": "N"
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

  Future<Response<dynamic>> getNotification() async {
    try {
      final String token = await storage.getStringValue("token") ?? "";
      Map<String, dynamic> headers = {
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json',
      };
      return await dio.get(
        "$baseUrl/api/notification/get-notification",
        options: Options(headers: headers),
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> getViewedNotification() async {
    try {
      return await dio.get("$baseUrl/api/notification/get-viewed-notification");
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }
    Future<Response<dynamic>> updateBulkNotificationIsView(List<String> notificationIds) async {
    final String token = await storage.getStringValue("token") ?? "";
    Map<String, dynamic> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    try {
      return await dio.put(
        "$baseUrl/api/notification/bulk-update-isView",
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
}