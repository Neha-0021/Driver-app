import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:driver_app/service/Driver/Driver.dart';

class DriverRatingState extends ChangeNotifier {
  List<dynamic> driverRating = [];
  final DriverRatingService _driverRatingService = DriverRatingService();

  Future<void> submitDriverRating(String bookingId, String rating) async {
    try {
      await _driverRatingService.driverRating(bookingId, rating);
    } catch (error) {
      print('Error submitting driver rating: $error');
    }
  }

  Future<void> getDriverRatingByBookingId(String bookingId) async {
    try {
      Response<dynamic> response =
          await _driverRatingService.getDriverRatingByBookingId(bookingId);
      driverRating = response.data;
      notifyListeners();
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
