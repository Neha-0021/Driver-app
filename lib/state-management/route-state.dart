import 'package:dio/dio.dart';
import 'package:driver_app/service/route/route.dart';
import 'package:flutter/material.dart';

class RouteDetailState extends ChangeNotifier {
  final RouteDetailService service = RouteDetailService();

  Map<String, dynamic> routeDetails = {};
  Map<String, dynamic> startingPoint = {};
  Map<String, dynamic> endPoint = {};
  List<dynamic> stoppageWithDetails = [];

  Future<void> getRouteDetailsByDriver(String date) async {
    try {
      Response response = await service.getRouteDetailsByDriver(date);
      routeDetails = Map<String, dynamic>.from(response.data["routeDetails"]);
    stoppageWithDetails = response.data["stoppageWithDetails"].reversed.toList();
      startingPoint = Map<String, dynamic>.from(response.data["startingPoint"]);
      endPoint = Map<String, dynamic>.from(response.data["endPoint"]);
      print('Stoppage with details: $stoppageWithDetails');
      notifyListeners();
    } catch (error) {
      print('Error fetching route details: $error');
    }
  }
}
