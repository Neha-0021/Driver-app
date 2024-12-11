import 'package:driver_app/service/Driver/Driver.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class DriverRatingState extends ChangeNotifier {
  final DriverRatingService ratingService = DriverRatingService();

  List<dynamic> driver = [];
  List<dynamic> users = [];
  int totalUsers = 0;
  double averageDriverRating = 0.0;

  Future<void> getDriverRatingByDriverId(String driverId) async {
    try {
      Response response =
          await ratingService.getDriverRatingByDriverId(driverId);
      driver = response.data["driverRatings"].reversed.toList();

      users = response.data["users"].reversed.toList();
      totalUsers = response.data["totalUsers"];
      averageDriverRating = response.data["averageDriverRating"];
      notifyListeners();
    } catch (error) {
      print('Error fetching driver ratings: $error');
    }
  }
}
