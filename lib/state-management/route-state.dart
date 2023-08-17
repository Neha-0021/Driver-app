import 'package:dio/dio.dart';
import 'package:driver_app/service/route/route.dart';
import 'package:flutter/material.dart';

class RouteDetailState extends ChangeNotifier {
  final RouteDetailService service = RouteDetailService();

  Map<String, dynamic> routeDetails = {};
  List<Map<String, dynamic>> allStoppages = [];
  Map<String, dynamic> startingPoint = {};
  Map<String, dynamic> endPoint = {};
  int totalPeopleToPickup = 0;

  Future<void> getRouteDetailsByDriver(String date) async {
    try {
      Response response = await service.getRouteDetailsByDriver(date);
      routeDetails = Map<String, dynamic>.from(response.data["routeDetails"]);
      allStoppages =
          List<Map<String, dynamic>>.from(response.data["allStoppages"]);
      startingPoint = Map<String, dynamic>.from(response.data["startingPoint"]);
      endPoint = Map<String, dynamic>.from(response.data["endPoint"]);
      totalPeopleToPickup = response.data["totalPeopleToPickup"];

      notifyListeners();
    } catch (error) {
      print('Error fetching route details: $error');
    }
  }
}
