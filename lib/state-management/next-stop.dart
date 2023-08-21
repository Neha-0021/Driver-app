import 'package:dio/dio.dart';
import 'package:driver_app/service/next-stop/next-stop.dart';
import 'package:flutter/material.dart';

class NextStoppageState extends ChangeNotifier {
  final NextStoppageService service = NextStoppageService();

  List<Map<String, dynamic>> nextStoppageDetails = [];
  List<Map<String, dynamic>> userDetails = []; 

  Future<void> getNextStoppage(String driverId, String routeId) async {
    try {
      Response response = await service.getNextStoppage(driverId, routeId);
      print('API Response: ${response.data}');

      nextStoppageDetails =
          List<Map<String, dynamic>>.from(response.data["nextStoppageDetails"]);
      userDetails =
          List<Map<String, dynamic>>.from(response.data["userDetails"]);

      notifyListeners();
    } catch (error) {
      print('Error fetching next stoppage data and user details: $error');
    }
  }
}
