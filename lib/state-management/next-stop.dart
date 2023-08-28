import 'package:dio/dio.dart';
import 'package:driver_app/service/next-stop/next-stop.dart';
import 'package:flutter/material.dart';

class NextStoppageState extends ChangeNotifier {
  final NextStoppageService service = NextStoppageService();

  List<Map<String, dynamic>> nextStoppageUserDetails = [];
  List<Map<String, dynamic>> routes = [];
  List<Map<String, dynamic>> stoppages = [];

  Future<void> getNextStoppage(String routeId, String stoppageId) async {
    try {
      Response response = await service.getNextStoppage(routeId, stoppageId);
      nextStoppageUserDetails = List<Map<String, dynamic>>.from(
          response.data["nextStoppageUserDetails"]);

      notifyListeners();
    } catch (error) {
      print('Error fetching next stoppage data and user details: $error');
    }
  }

  Future<void> getAllRoutes() async {
    try {
      final response = await service.getAllRoutes();
      routes = List<Map<String, dynamic>>.from(response.data["routes"]);
      notifyListeners();
    } catch (error) {
      print("Error fetching routes: $error");
    }
  }

  Future<void> getStoppagesByRouteId(String routeId) async {
    try {
      final response = await service.getStoppagesByRouteId(routeId);
      stoppages = List<Map<String, dynamic>>.from(response.data["data"]);
      notifyListeners();
    } catch (error) {
      print("Error fetching stoppages: $error");
    }
  }
}
