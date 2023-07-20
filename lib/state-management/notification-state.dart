import 'package:dio/dio.dart';
import 'package:driver_app/service/notification/notification-services.dart';
import 'package:flutter/foundation.dart';


class NotificationState extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  List<dynamic> notifications = [];
  List<dynamic> viewedNotifications = [];
  List<dynamic> BulkNotificationIsView = [];
  Future<void> getNotification() async {
    try {
      Response response = await _notificationService.getNotification();
      notifications = response.data["notification"];
      notifyListeners();
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }

  Future<void> getViewedNotification() async {
    try {
      Response response = await _notificationService.getViewedNotification();
      viewedNotifications = response.data["view notification"];
      notifyListeners();
    } catch (error) {
      print('Error fetching viewed notifications: $error');
    }
  }

  Future<void> updateBulkNotificationIsView(
      List<String> notificationIds) async {
    try {
      Response response = await _notificationService
          .updateBulkNotificationIsView(notificationIds);
      BulkNotificationIsView = response.data["BulkNotificationIsView"];
    } catch (error) {
      print('Error updating bulk notification isView: $error');
    }
  }
}
