import 'dart:async';

import 'package:driver_app/state-management/GeolocationProvider.dart';
import 'package:driver_app/service/mapper/map.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    final geolocation =
        Provider.of<GeolocationProvider>(context, listen: false);
    await geolocation.getCurrentLocation();
    userLocation = geolocation.userLocation;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(userLocation));

    userMarker = Marker(
      markerId: MarkerId("userMarker"),
      position: userLocation,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: userLocation,
          zoom: 14.0,
        ),
        markers: {
          userMarker,
        },
        polylines: _routeCoordinates,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          
        },
      ),
    );
  }
}
