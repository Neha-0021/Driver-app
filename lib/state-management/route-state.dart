import 'package:driver_app/service/route/route.dart';
import 'package:flutter/material.dart';


class RouteDetailState extends ChangeNotifier {
  final RouteDetailService service = RouteDetailService();

  Map<String, dynamic> routeDetails = {};

  Future<void> getRouteDetailsByDriver() async {
    try {
      final response = await service.getRouteDetailsByDriver();
      routeDetails = response.data;
      notifyListeners();
    } catch (error) {
      print('Error fetching route details: $error');
    }
  }
}
