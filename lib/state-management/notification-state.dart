import 'package:dio/dio.dart';
import 'package:driver_app/service/notification/notification.dart';
import 'package:flutter/foundation.dart';


class DriverNotificationState extends ChangeNotifier {
  final DriverNotificationService _driverNotificationService =
      DriverNotificationService();

  List<dynamic> notifications = [];
  List<dynamic> viewedNotifications = [];
  List<dynamic> BulkDriverNotificationIsView = [];

  Future<void> getDriverNotification() async {
    try {
      Response response = await _driverNotificationService.getDriverNotification();
      notifications = response.data["notification"].reversed.toList();
      viewedNotifications = [];
      List<String> ids = response.data["notification"]
          .map<String>((obj) => obj["_id"].toString())
          .toList();
      updateBulkDriverNotificationIsView(ids);
      notifyListeners();
    } catch (error) {
      print('Error fetching driver notifications: $error');
    }
  }

  Future<void> getViewedDriverNotification() async {
    try {
      Response response = await _driverNotificationService.getViewedDriverNotification();
      viewedNotifications = response.data["notification"].reversed.toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching viewed driver notifications: $error');
    }
  }

  Future<void> updateBulkDriverNotificationIsView(List<String> notificationIds) async {
    try {
      Response response = await _driverNotificationService.updateBulkDriverNotificationIsView(notificationIds);
    } catch (error) {
      print('Error updating bulk driver notification isView: $error');
    }
  }

  Future<void> deleteDriverNotificationById(String id) async {
    try {
      Response response = await _driverNotificationService.deleteDriverNotificationById(id);
    } catch (error) {
      print('Error deleting driver notification by id: $error');
    }
  }

  Future<void> deleteAllDriverNotification() async {
    try {
      Response response = await _driverNotificationService.deleteAllDriverNotification();
    } catch (error) {
      print('Error deleting all driver notifications: $error');
    }
  }
}
