import 'dart:async';
import 'package:dio/dio.dart';
import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/atom/Button.dart';
import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';
import 'package:driver_app/atom/home/HomeListCard.dart';

import 'package:driver_app/atom/home/MapButton.dart';
import 'package:driver_app/service/mapper/map.dart';
import 'package:driver_app/state-management/start-ride.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Mapper extends StatefulWidget {
  const Mapper({Key? key}) : super(key: key);

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

  Marker userMarker = Marker(markerId: MarkerId("userMarker"));

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.1904, 81.2849),
    zoom: 14.4746,
  );

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
    getDirection("$latitude,$longitude", "21.1904, 81.2849");
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Container(
                height: 390,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  markers: {
                    userMarker,
                  },
                  polylines: _routeCoordinates,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MapButton(
                  buttonText: 'Go to starting Point',
                  onPressed: () async {
                    await getCurrentLocation();
                    final GoogleMapController controller =
                        await _controller.future;
                    if (userLocation.latitude != 0.0 &&
                        userLocation.longitude != 0.0) {
                      controller.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: userLocation,
                          zoom: 10.0,
                        ),
                      ));
                    }
                  },
                  width: 140,
                  color: const Color(0xFF192B46),
                ),
                MapButton(
                  buttonText: 'Start Ride',
                  onPressed: () {},
                  width: 110,
                  color: const Color(0xFF192B46),
                ),
                MapButton(
                  buttonText: 'Stop Ride',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StopRide();
                      },
                    );
                  },
                  color: Color(0xFFECB21E),
                  width: 85,
                ),
              ],
            ),
            const HomeListCard(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: CustomButton(
                label: 'View All',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NextStop()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
