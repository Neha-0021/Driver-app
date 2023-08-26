import 'package:dio/dio.dart';
import 'package:driver_app/service/next-stop/next-stop.dart';
import 'package:flutter/material.dart';

class NextStoppageState extends ChangeNotifier {
  final NextStoppageService service = NextStoppageService();

  List<Map<String, dynamic>> nextStoppageUserDetails = [];

  Future<void> getNextStoppage(String driverId, String routeId) async {
    try {
      Response response = await service.getNextStoppage(driverId, routeId);
       nextStoppageUserDetails = List<Map<String, dynamic>>.from(
          response.data["nextStoppageUserDetails"]);

      notifyListeners();
    } catch (error) {
      print('Error fetching next stoppage data and user details: $error');
    }
  }
}
