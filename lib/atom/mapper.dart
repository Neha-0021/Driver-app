import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Mapper extends StatefulWidget {
  const Mapper({super.key});

  @override
  State<StatefulWidget> createState() {
    return MapperComponent();
  }
}

class MapperComponent extends State<Mapper> {
  Set<Polyline> _routeCoordinates = Set<Polyline>();
  int polylineCounter = 1;
  LatLng userLocation = LatLng(0.0, 0.0);
  Marker userMarker = Marker(markerId: MarkerId("userMarket"));

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    // Fetch user location after 5 seconds
    Timer(Duration(seconds: 5), getCurrentLocation);
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;
    setState(() {
      userLocation = LatLng(latitude, longitude);
      userMarker = Marker(
        markerId: const MarkerId("userMarker"),
        icon: BitmapDescriptor.defaultMarker,
        position: userLocation,
      );
    });
    getDirection("$latitude,$longitude", "21.1938,81.3509");
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: userLocation, zoom: 14.0),
    ));
  }

  getDirection(origin, destination) async {
    Response resp = await Dio().get(
        "https://maps.googleapis.com/maps/api/directions/json",
        queryParameters: {"origin": origin, "destination": destination});
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
    setState(() {
      _routeCoordinates = tempRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0), // Initially set to 0,0
          zoom: 14.0,
        ),
        markers: {userMarker}, // Show only user's location marker
        polylines: _routeCoordinates,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}




