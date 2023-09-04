import 'package:driver_app/model/rating-model.dart';
import 'package:driver_app/service/Driver/Driver.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class DriverRatingState extends ChangeNotifier {
  final DriverRatingService ratingService = DriverRatingService();

  List<DriverRatings> driverRatings = [];
  List<Users> users = [];
  int totalUsers = 0;
  double averageDriverRating = 0.0;

  Future<void> addDriverRating(String bookingId, int rating) async {
    try {
      Response response = await ratingService.driverRating(bookingId, rating);

      notifyListeners();
    } catch (error) {
      print('Error add driverRating: $error');
    }
  }

  Future<void> deleteDriverRating(String ratingId) async {
    try {
      Response response = await ratingService.deleteDriverRating(ratingId);

      notifyListeners();
    } catch (error) {
      print('Error deleting driver rating: $error');
    }
  }

  Future<void> getDriverRatingByDriverId(String driverId) async {
    try {
      Response response =
          await ratingService.getDriverRatingByDriverId(driverId);
      RatingModel ratingModel = RatingModel.fromJson(response.data);

      driverRatings = ratingModel.driverRatings!;
      users = ratingModel.users!;
      totalUsers = ratingModel.totalUsers!;
      averageDriverRating = ratingModel.averageDriverRating!;
    } catch (error) {
      print('Error getting driver rating by driver ID: $error');
    }
  }
}