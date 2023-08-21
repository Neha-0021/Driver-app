import 'dart:async';
import 'package:dio/dio.dart';
import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/atom/Button.dart';
import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';
import 'package:driver_app/atom/home/HomeListCard.dart';
import 'package:driver_app/atom/home/MapButton.dart';
import 'package:driver_app/service/mapper/map.dart';
import 'package:driver_app/service/start-ride/start-ride.dart';
import 'package:driver_app/state-management/route-state.dart';
import 'package:driver_app/utils/distance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Mapper extends StatefulWidget {
  const Mapper({super.key});

  @override
  State<StatefulWidget> createState() {
    return MapperComponent();
  }
}

class MapperComponent extends State<Mapper> {
  Timer? locationUpdateTimer;
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
        position: userLocation,
      );
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

  DistanceUtils distanceUtils = DistanceUtils();
  double targetLat = 21.1904;
  double targetLon = 81.2849;
  String targetTime = "08:00 AM";

  double thresholdDistance = 10.0;
  int thresholdTimeDifferenceMinutes = 10;
  bool rideStarted = false;
  void checkAndStartRide() async {
    String distanceString = await distanceUtils
        .getCurrentLocationAndCalculateDistance(targetLat, targetLon);

    double distance = double.parse(distanceString);

    DateTime now = DateTime.now();
    DateTime targetDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(targetTime.split(':')[0]),
      int.parse(targetTime.split(':')[1].split(' ')[0]),
    );

    Duration timeDifference = targetDateTime.difference(now);

    if (timeDifference.inMinutes <= thresholdTimeDifferenceMinutes &&
        distance <= thresholdDistance) {
      setState(() {
        rideStarted = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final routeState = Provider.of<RouteDetailState>(context, listen: false);
    routeState.getRouteDetailsByDriver('2023-07-26');
    locationUpdateTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getCurrentLocation();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    locationUpdateTimer?.cancel();
    super.dispose();
  }

  ShuttleTrackingService service = ShuttleTrackingService();

  void startShuttle(BuildContext context) async {
    try {
      // Call the startShuttleTracking method here
      Response response = await service.startShuttleTracking(
        userLocation.latitude,
        userLocation.longitude,
      );
      // Handle the response as needed
      if (response.statusCode == 200) {
        // Shuttle tracking started successfully
        // You can update your UI or take further actions here
      } else {
        // Handle errors or show appropriate messages
        print(
            "Error: Shuttle tracking request failed with status code ${response.statusCode}");
        // You can also log additional error details if available in the response
        // print("Error Details: ${response.body}");
      }
    } catch (error) {
      // Handle exceptions, e.g., network errors
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteDetailState>(
      builder: (context, routeState, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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

                        checkAndStartRide();
                      }
                    },
                    width: 140,
                    color: const Color(0xFF192B46),
                  ),
                  MapButton(
                    buttonText: 'Start Ride',
                    disabled: !rideStarted,
                    onPressed: () async {
                      if (rideStarted) {
                        startShuttle(context);
                      }
                    },
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
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xFF6A7B8D)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/Vectorm.png',
                          width: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Next Stop & Customers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'PublicaSans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: routeState.allStoppages.length,
                itemBuilder: (context, index) {
                  final home = routeState.allStoppages[index];
                  return HomeListCard(data: home);
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
      ),
    );
  }
}
