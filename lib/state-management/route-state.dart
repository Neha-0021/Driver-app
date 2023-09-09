import 'package:dio/dio.dart';
import 'package:driver_app/service/route/route.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';

class RouteDetailState extends ChangeNotifier {
  final RouteDetailService service = RouteDetailService();
  AlertBundle alert = AlertBundle();

  Map<String, dynamic> routeDetails = {};
  Map<String, dynamic> startingPoint = {};
  Map<String, dynamic> endPoint = {};
  List<dynamic> stoppageWithDetails = [];
  Map<String, dynamic> starttracking = {};
  Map<String, dynamic> updatetracking = {};
  int totalUsers = 0;

  Future<void> getRouteDetailsByDriver(String date) async {
    try {
      Response response = await service.getRouteDetailsByDriver(date);
      routeDetails = Map<String, dynamic>.from(response.data["routeDetails"]);
      stoppageWithDetails = response.data["stoppageWithDetails"];

      startingPoint = Map<String, dynamic>.from(response.data["startingPoint"]);
      endPoint = Map<String, dynamic>.from(response.data["endPoint"]);
      print('Stoppage with details: $stoppageWithDetails');
      totalUsers = response.data["totalUsers"];
      notifyListeners();
    } catch (error) {
      print('Error fetching route details: $error');
    }
  }

  Future<void> startShuttleTracking(
      double driverLatitude, double driverLongitude) async {
    final response =
        await service.startShuttleTracking(driverLatitude, driverLongitude);
if (response.statusCode == 200) {
      starttracking = response.data["data"];
      print('Shuttle tracking started successfully');
    } else {
      print('Error starting shuttle tracking');
    }
  }

  Future<void> updateShuttleTracking(
    String id,
    String driverCurrentLocation,
  ) async {
    final response =
        await service.updateShuttleTracking(id, driverCurrentLocation);

    if (response.statusCode == 200) {
      updatetracking = response.data["updatedData"];
      print('Shuttle tracking updated successfully');
    } else {
      print('Error updating shuttle tracking');
    }
  }
}
