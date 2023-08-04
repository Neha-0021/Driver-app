
import 'package:dio/dio.dart';
import 'package:driver_app/service/route/route.dart';
import 'package:flutter/material.dart';

class RouteDetailState extends ChangeNotifier {
  final RouteDetailService service = RouteDetailService();

  Response? routeDetailResponse; 

  void getRouteDetailByDriver() async {
    try {
      routeDetailResponse = await service.getRouteDetailsByDriver({});
      notifyListeners();
    } catch (error) {
      print('Error fetching route details: $error');
    }
  }
}
