import 'package:dio/dio.dart';
import 'package:driver_app/service/History/history.dart';
import 'package:flutter/foundation.dart';

class DriverHistoryState extends ChangeNotifier {
  final DriverHistoryService historyService = DriverHistoryService();


  List<dynamic> completeHistory = [];

  Future<void> getDriverCompleteHistory() async {
    try {
      Response response = await historyService.getDriverCompleteHistory();
      completeHistory = response.data["stopRoute"].reversed.toList();

      List<String> ids = response.data["stopRoute"]
          .map<String>((obj) => obj["_id"].toString())
          .toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }
}
