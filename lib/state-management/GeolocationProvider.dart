import 'package:driver_app/service/mapper/map.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// 1. GeolocationProvider
class GeolocationProvider extends ChangeNotifier {
  LatLng userLocation = LatLng(0.0, 0.0);
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
     latitude = position.latitude;
     longitude = position.longitude;
    userLocation = LatLng(latitude, longitude);

    notifyListeners();
  }
}

class DirectionProvider extends ChangeNotifier {
  MapperMap map = MapperMap();
  Set<Polyline> _routeCoordinates = Set<Polyline>();
  int polylineCounter = 1;

  Set<Polyline> get routeCoordinates => _routeCoordinates;

  Future<void> getDirection(origin, destination) async {
    Response resp = await map.getDirectionAPI(origin, destination);
    final responseData = resp.data;
    if (responseData['status'] == 'OK') {
      final List<dynamic> routes = responseData['routes'];
      if (routes.isNotEmpty) {
        final Map<String, dynamic> route = routes[0];
        final Map<String, dynamic> overviewPolyline =
            route['overview_polyline'];
        final String points = overviewPolyline['points'];
        _decodePolyline(points);
      }
    }
  }

  void _decodePolyline(String polyline) {
    List<PointLatLng> points = PolylinePoints().decodePolyline(polyline);
    final polylineIds = "polylineID$polylineCounter";
    polylineCounter++;
    Set<Polyline> tempRoute = Set<Polyline>();
    tempRoute.add(Polyline(
      polylineId: PolylineId(polylineIds),
      width: 5,
      color: Colors.blue,
      points: points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
    ));
    _routeCoordinates = tempRoute;
    notifyListeners();
  }
}
