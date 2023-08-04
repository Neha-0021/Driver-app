import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Mapper extends StatefulWidget {
  const Mapper({super.key});

  @override
  State<StatefulWidget> createState() {
    return MapperComponent();
  }
}

class MapperComponent extends State<Mapper> {
  LatLng userLocation = LatLng(0.0, 0.0);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Marker userMarker = Marker(markerId: MarkerId("userMarker"));

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getCurrentLocation();
    }
  }

  void requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      configureBackgroundLocation();
      getCurrentLocation();
    }
  }

  void configureBackgroundLocation() {
    BackgroundLocation.setAndroidNotification(
      title: "Notification title",
      message: "Notification message",
      icon: "@mipmap/ic_launcher",
    );

    BackgroundLocation.setAndroidConfiguration(1000);
    startBackgroundLocationService();
  }

  void startBackgroundLocationService() {
    BackgroundLocation.startLocationService();
  }

  void getLocationUpdates() {
    BackgroundLocation.getLocationUpdates((location) {
      print(location);

      setState(() {
        userLocation = LatLng(location.latitude!, location.longitude!);
        userMarker = Marker(
          markerId: const MarkerId("userMarker"),
          icon: BitmapDescriptor.defaultMarker,
          position: userLocation,
        );
      });
    });
  }

  void stopBackgroundLocationService() {
    BackgroundLocation.stopLocationService();
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

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(userLocation));
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
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}





