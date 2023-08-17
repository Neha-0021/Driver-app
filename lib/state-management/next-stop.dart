import 'package:flutter/material.dart';
import 'package:driver_app/service/next-stop/next-stop.dart';

class NextStoppageProvider extends ChangeNotifier {
  final NextStoppageService service = NextStoppageService();

  List<Map<String, dynamic>> nextStoppages = [];

  Future<void> fetchNextStoppages(String driverId, String stoppageId) async {
    try {
      final response = await service.getNextStoppage(driverId, stoppageId);
       print('Response Data: ${response.data}');
      if (response.data['status'] == 'success') {
        nextStoppages = List<Map<String, dynamic>>.from(
          response.data['nextStoppageDetails'],
        );
        notifyListeners();
      } else {
        print('Error: ${response.data['status']}');
      }
    } catch (error) {
      print('Error fetching next stoppage data: $error');
    }
  }
}




