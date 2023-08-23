import 'dart:math';
import 'package:geolocator/geolocator.dart';

class DistanceUtils {
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusKm = 6371;
    const double metersPerKm = 1000;

    double degToRad(double degree) => degree * (pi / 180.0);

    double dLat = degToRad(lat2 - lat1);
    double dLon = degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRad(lat1)) *
            cos(degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distanceKm = earthRadiusKm * c; // Distance in kilometers

    double distanceMeters = distanceKm * metersPerKm; // Distance in meters

    return distanceMeters;
  }

  Future<String> getCurrentLocationAndCalculateDistance(
      double targetLat, double targetLon) async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double userLat = position.latitude;
    double userLon = position.longitude;

    double totalDistance =
        calculateDistance(userLat, userLon, targetLat, targetLon);

    return totalDistance.toStringAsFixed(2) + " m";
  }
}
