import 'dart:async';
import 'package:dio/dio.dart';
import 'package:driver_app/service/mapper/map.dart';
import 'package:driver_app/service/profile/profile.dart';
import 'package:driver_app/service/route/route.dart';
import 'package:driver_app/service/stop-ride.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:driver_app/utils/distance.dart';
import 'package:driver_app/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class RouteDetailState extends ChangeNotifier {
  final RouteDetailService service = RouteDetailService();
  final ProfileService Service = ProfileService();
  AlertBundle alert = AlertBundle();
  DistanceUtils distanceUtils = DistanceUtils();
  StopRideService stop = StopRideService();
  bool rideStarted = false;
  bool isLoading = true;
  late double latitude;
  late double longitude;
  Map<String, dynamic> routeDetails = {};
  Map<String, dynamic> startingPoint = {};
  Map<String, dynamic> endPoint = {};
  List<dynamic> stoppageWithDetails = [];
  Map<String, dynamic> starttracking = {};
  Map<String, dynamic> updatetracking = {};
  int totalUsers = 0;

  Map<String, dynamic> driverData = {};
  LatLng userLocation = LatLng(0.0, 0.0);

  PhoneStorage phoneStorage = PhoneStorage();
  MapperMap map = MapperMap();
  Set<Polyline> routeCoordinates = Set<Polyline>();
  int polylineCounter = 1;

  List<Marker> stoppageMarkers = [];
  Marker startPointMarker = const Marker(
    markerId: MarkerId("startPointMarker"),
  );

  void getDriver() async {
    Response driverDetails = await Service.getDriverProfile();
    driverData = driverDetails.data["driver"];
    notifyListeners();
  }

  Marker userMarker = const Marker(
    markerId: MarkerId("userMarker"),
  );
  void updateUserMarker(Marker marker) {
    userMarker = marker;
    notifyListeners();
  }

  Future<void> getRouteDetailsByDriver(String date) async {
    try {
      Response response = await service.getRouteDetailsByDriver(date);
      routeDetails = Map<String, dynamic>.from(response.data["routeDetails"]);
      stoppageWithDetails = response.data["stoppageWithDetails"];

      startingPoint = Map<String, dynamic>.from(response.data["startingPoint"]);
      endPoint = Map<String, dynamic>.from(response.data["endPoint"]);
      print('Stoppage with details: $stoppageWithDetails');
      totalUsers = response.data["totalUsers"];
      notifyListeners();
    } catch (error) {
      print('Error fetching route details: $error');
    }
  }

 void startShuttle( ) async {
    try {
      Response response = await service.startShuttleTracking(
        userLocation.latitude,
        userLocation.longitude,
      );
      if (response.statusCode == 200) {
        print('StartResponse: $response');
        print( "Shuttle tracking started");
      } else {
        print( "Shuttle tracking not started try again");
      }
    } catch (error) {
      print("Error: $error");
    }
  }


  Future<void> setCurrentLocation(Position position) async {
    latitude = position.latitude;
    longitude = position.longitude;
    userLocation = LatLng(latitude, longitude);

    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    notifyListeners();
    phoneStorage.setStringValue('destination', 'New Destination');
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setCurrentLocation(position);
      isLoading = false;
    } catch (e) {
      print("Error getting location: $e");
    }

    notifyListeners();
  }

  Future<void> getDirections(String origin, String destination) async {
    phoneStorage.setStringValue('destination', 'New Destination');
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
      double startingPointLatitude = double.parse(startingPoint["latitude"]);
      double startingPointLongitude = double.parse(startingPoint["longitude"]);
      startPointMarker = Marker(
          markerId: const MarkerId("startPointMarker"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(startingPointLatitude, startingPointLongitude));
      for (var stoppage in stoppageWithDetails) {
        double stoppageLatitude =
            double.parse(stoppage["stoppage"]["latitude"]);
        double stoppageLongitude =
            double.parse(stoppage["stoppage"]["longitude"]);
        Marker stoppageMarker = Marker(
          markerId: MarkerId("stoppage_${stoppage["stoppage"]["_id"]}"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(stoppageLatitude, stoppageLongitude),
        );
        stoppageMarkers.add(stoppageMarker);
      }
    }
    notifyListeners();
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
        points: points.map((e) => LatLng(e.latitude, e.longitude)).toList()));

    routeCoordinates = tempRoute;
  }

  void checkAndStartRide(BuildContext context) async {
    phoneStorage.setStringValue('destination', 'New Destination');
    DateTime givenTime = DateFormat('HH:mm').parse(routeDetails['timing_form']);
    givenTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, givenTime.hour, givenTime.minute);

    double startingPointLatitude = double.parse(startingPoint["latitude"]);
    double startingPointLongitude = double.parse(startingPoint["longitude"]);
    String distanceString =
        await distanceUtils.getCurrentLocationAndCalculateDistance(
            startingPointLatitude, startingPointLongitude);
    String startingpoint = distanceString.replaceAll(RegExp(r'[^0-9.]'), '');
    double? distance = double.tryParse(startingpoint);
    print('Distance  $distance');

    DateTime currentTime = DateTime.now();
    int timeDifference = givenTime.difference(currentTime).inMinutes;
    print('time : $timeDifference');
    if (distance != null && distance <= 10.0 && timeDifference <= 10 ||
        timeDifference <= 0) {
      rideStarted = true;
      notifyListeners();
    }
  }

  void updateShuttle() async {
    try {
      Response response = await service.updateShuttleTracking(
        userLocation.latitude,
        userLocation.longitude,
      );
      if (response.statusCode == 200) {
        print("Shuttle location updated");
      } else {
        print("Failed to update shuttle location");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  void stopRide() async {
    try {
      String reason = 'All users dropped';

      Response response = await stop.stopRide(reason);

      if (response.statusCode == 200) {
        print("Successfully stopped the ride");
      } else {
        {
          print("Ride could not be stopped.");
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
