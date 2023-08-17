import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/Modal/RatingModal.dart';

class DriverRatingService {
  final Dio dio = Dio();
  final String baseUrl = ServiceConfig.baseUrl;

  Future<Response<dynamic>> DriverRating(String bookingId, String rating) async {
    final Map<String, dynamic> data = {
      "bookingId": bookingId,
      "rating": rating,
    };

    try {
      final response = await dio.post(
        "$baseUrl/api/driver/driver-rating",
        data: data,
      );
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteDriverRating(String ratingId) async {
    try {
      final response = await dio.delete(
        "$baseUrl/api/driver/delete-driver-rating/$ratingId",
      );
      return response;
    } catch (err) {
      if (err is DioError) {
        return err.response!;
      }
      rethrow;
    }
  }
}