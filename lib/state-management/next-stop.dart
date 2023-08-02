import 'package:driver_app/service/next-stop/next-stop.dart';
import 'package:flutter/material.dart';

class NextStoppageState extends ChangeNotifier {
  final NextStoppageService service = NextStoppageService();

  Map<String, dynamic> nextStoppage = {}; 

  Future<void> getNextStoppage() async {
    try {
      final response = await service.getNextStoppage();
      nextStoppage = response.data; 
      notifyListeners();
    } catch (error) {
      print('Error fetching next stoppage data: $error');
    }
  }
}
