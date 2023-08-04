import 'dart:async';

import 'package:dio/dio.dart';
import 'package:driver_app/service/mapper/map.dart';
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
  MapperMap map = MapperMap();
  Set<Polyline> _routeCoordinates = Set<Polyline>();
  int polylineCounter = 1;
  LatLng userLocation = LatLng(0.0, 0.0);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Marker userMarker = Marker(markerId: MarkerId("userMarket"));

  static const Marker shuttleMarker = Marker(
      markerId: MarkerId("shuttleMarker"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(21.2514, 81.6296));

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.1938, 81.3509),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    if (mounted) {
      // getDirection();
      getCurrentLocation();
    }
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
          position: userLocation);
    });
    getDirection("$latitude,$longitude", "21.1938, 81.3509");
  }

  getDirection(origin, destination) async {
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
        points: points.map((e) => LatLng(e.latitude, e.longitude)).toList()));
    setState(() {
      _routeCoordinates = tempRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: {
          userMarker,
          shuttleMarker,
        },
        polylines: _routeCoordinates,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
