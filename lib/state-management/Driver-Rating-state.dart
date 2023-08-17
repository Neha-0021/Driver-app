import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/service/Driver/Driver.dart';
import 'package:driver_app/Modal/RatingModal.dart';

class DriverRatingState extends ChangeNotifier {
   List<RatingModel> driverRating = [];
  
  final DriverRatingService _driverRatingService = DriverRatingService();

  Future<void> submitDriverRating(String bookingId, String rating) async {
    try {
      Response<dynamic> response = await _driverRatingService.DriverRating(bookingId, rating);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
        RatingModel ratingModel = RatingModel.fromJson(responseData);
        driverRating.add(ratingModel);
        notifyListeners();
      } else {
        print('Error submitting driver rating: ${response.statusCode}');
      }
    } catch (error) {
      print('Error submitting driver rating: $error');
    }
  }

  Future<void> deleteDriverRating(String ratingId) async {
    try {
      await _driverRatingService.deleteDriverRating(ratingId);
      driverRating.removeWhere((rating) => rating.id == ratingId);
      notifyListeners();
    } catch (error) {
      print('Error deleting driver rating: $error');
    }
  }
}