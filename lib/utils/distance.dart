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

    double totalDistance = calculateDistance(userLat, userLon, targetLat, targetLon);

    return totalDistance.toStringAsFixed(2) + " m";
  }
}


class TimeUtils {
  Duration calculateTimeDifference(DateTime targetTime) {
    DateTime currentTime = DateTime.now();
    return targetTime.difference(currentTime);
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '$hours hours, $minutes minutes, $seconds seconds';
  }

  Future<String> getTimeDifferenceToTargetTime(int targetHour, int targetMinute) async {
    DateTime now = DateTime.now();
    DateTime targetTime = DateTime(now.year, now.month, now.day, targetHour, targetMinute);

    Duration timeDifference = calculateTimeDifference(targetTime);

    return formatDuration(timeDifference);
  }
}
