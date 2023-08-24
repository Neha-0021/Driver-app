import 'package:dio/dio.dart';
import 'package:driver_app/service/notification/notification.dart';
import 'package:flutter/foundation.dart';

class DriverNotificationState extends ChangeNotifier {
  final DriverNotificationService driverNotificationService =
      DriverNotificationService();

  List<dynamic> notifications = [];
  List<dynamic> viewedNotifications = [];
  List<dynamic> BulkDriverNotificationIsView = [];

  Future<void> getDriverNotification() async {
    try {
      Response response =
          await driverNotificationService.getDriverNotification();
      notifications = response.data["driverNotification"].reversed.toList();
      viewedNotifications = [];
      List<String> ids = response.data["driverNotification"]
          .map<String>((obj) => obj["_id"].toString())
          .toList();
      updateBulkDriverNotificationIsView(ids);
      notifyListeners();
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }

 Future<void> getViewedNotification() async {
    try {
      print("inside");
      Response response = await driverNotificationService.getViewedDriverNotification();
      viewedNotifications = response.data["notification"].reversed.toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching viewed notifications: $error');
    }
  }

  Future<void> updateBulkDriverNotificationIsView(
      List<String> driverNotificationIds) async {
    try {
      Response response = await driverNotificationService
          .updateBulkDriverNotificationIsView(driverNotificationIds);
    } catch (error) {
      print('Error updating bulk driver notification isView: $error');
    }
  }

  Future<void> deleteDriverNotificationById(String id) async {
    try {
      Response response =
          await driverNotificationService.deleteDriverNotificationById(id);
    } catch (error) {
      print('Error deleting driver notification by id: $error');
    }
  }

  Future<void> deleteAllDriverNotification() async {
    try {
      Response response =
          await driverNotificationService.deleteAllDriverNotification();
    } catch (error) {
      print('Error deleting all driver notifications: $error');
    }
  }
}
