import 'package:dio/dio.dart';
import 'package:driver_app/service/config.dart';
import 'package:driver_app/utils/storage.dart';
import 'package:geolocator/geolocator.dart';


Dio dio = Dio();

class MapperMap {
  PhoneStorage storage = PhoneStorage();
  String mapperHost = ServiceConfig.mapperHost;
  String mapperKey = ServiceConfig.mapperKey;

  Future<Response<dynamic>> getLocationfromSearch(search) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double latitude = position.latitude;
      double longitude = position.longitude;
      return await dio.get(
        "$mapperHost/api/search?fm_token=$mapperKey&text=$search&currentlatitude=$latitude&currentlongitude=$longitude&type=web&radius=200",
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  //
  Future<Response<dynamic>> getLocationfromGoogleSearch(search) async {
    try {
      const String apiKey = ServiceConfig.googleAPIKey;
      final String encodedAddress = Uri.encodeComponent(search);
      final String apiUrl =
          'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';
      return await dio.get(
        apiUrl,
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }

  
  Future<Response<dynamic>> getDirectionAPI(
      originLatLng, destinationLatLng) async {
    try {
      const String apiKey = ServiceConfig.googleAPIKey;
      final String apiUrl =
          'https://maps.googleapis.com/maps/api/directions/json?origin=$originLatLng&destination=$destinationLatLng&key=$apiKey';
      return await dio.get(
        apiUrl,
      );
    } catch (err) {
      if (err is DioException) {
        return err.response!;
      }
      rethrow;
    }
  }
}
