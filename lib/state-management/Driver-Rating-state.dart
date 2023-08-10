import 'package:dio/dio.dart';
import 'package:driver_app/service/Driver/Driver.dart';
import 'package:flutter/foundation.dart';

class DriverRatingState extends ChangeNotifier {
  List<dynamic> driverRating = [];
  final DriverRatingService _driverRatingService = DriverRatingService();

  Future<void> DriverRating(String bookingId, String rating) async {
    try {
      await _driverRatingService.DriverRating(bookingId, rating);
    } catch (error) {
      print('Error submitting driver rating: $error');
    }
  }

  Future<void> getDriverRatingByBookingId(String bookingId) async {
    try {
      Response response =
          await _driverRatingService.getDriverRatingByBookingId(bookingId);
    } catch (error) {
      print('Error fetching driver rating by booking ID: $error');
    }
  }

  Future<void> deleteDriverRating(String ratingId) async {
    try {
      await _driverRatingService.deleteDriverRating(ratingId);
    } catch (error) {
      print('Error deleting driver rating: $error');
    }
  }
}
