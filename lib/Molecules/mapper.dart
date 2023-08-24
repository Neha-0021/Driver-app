import 'dart:async';
import 'package:dio/dio.dart';
import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/atom/Button.dart';
import 'package:driver_app/atom/Pop-Up/CompleteRide.dart';
import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';
import 'package:driver_app/atom/home/HomeListCard.dart';
import 'package:driver_app/atom/home/MapButton.dart';
import 'package:driver_app/service/mapper/map.dart';
import 'package:driver_app/service/start-ride/start-ride.dart';
import 'package:driver_app/state-management/route-state.dart';
import 'package:driver_app/utils/alert.dart';
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

  Marker startPointMarker = const Marker(
    markerId: MarkerId("startPointMarker"),
  );
  Marker endPointMarker = const Marker(
    markerId: MarkerId("endPointMarker"),
  );

  Marker firstStopMarker = const Marker(
    markerId: MarkerId("firstStopMarker"),
  );

  Marker secondStopMarker = const Marker(
    markerId: MarkerId("secondStopMarker"),
  );

  Marker thirdStopMarker = const Marker(
    markerId: MarkerId("thirdStopMarker"),
  );

  Marker forthStopMarker = const Marker(
    markerId: MarkerId("forthStopMarker"),
  );

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
    if (mounted) {
      setState(() {
        userLocation = LatLng(latitude, longitude);
        userMarker = Marker(
            markerId: const MarkerId("userMarker"),
            icon: BitmapDescriptor.defaultMarker,
            position: userLocation);
        startPointMarker = const Marker(
            markerId: MarkerId("startPointMarker"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(21.1904, 81.2849));
        endPointMarker = const Marker(
          markerId: MarkerId("endPointMarker"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(22.0797, 82.1409),
          infoWindow: InfoWindow(title: "5"),
        );
        firstStopMarker = const Marker(
          markerId: MarkerId("firstStopMarker"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(21.199617, 81.335226),
          infoWindow: InfoWindow(title: "1"),
        );
        secondStopMarker = const Marker(
          markerId: MarkerId("secondStopMarker"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(21.252625, 81.518494),
          infoWindow: InfoWindow(title: "2"),
        );
        thirdStopMarker = const Marker(
          markerId: MarkerId("thirdStopMarker"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(21.251385, 81.629639),
          infoWindow: InfoWindow(title: "3"),
        );
        forthStopMarker = const Marker(
          markerId: MarkerId("forthStopMarker"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(21.732599, 81.946098),
          infoWindow: InfoWindow(title: "4"),
        );
      });
    }
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

  double thresholdDistance = 10.0;
  bool rideStarted = false;
  void checkAndStartRide() async {
    String distanceString = await distanceUtils
        .getCurrentLocationAndCalculateDistance(targetLat, targetLon);
    double distance = double.parse(distanceString);
    if (distance <= thresholdDistance) {
      setState(() {
        rideStarted = true;
      });
    }
  }

  double endLat = 22.0797;
  double endLon = 82.1409;
  bool isRideComplete = false;
  void destination() async {
    String distanceString = await distanceUtils
        .getCurrentLocationAndCalculateDistance(endLat, endLon);
    double distance = double.parse(distanceString);
    if (distance <= thresholdDistance) {
      setState(() {
        isRideComplete = true;
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
    locationUpdateTimer?.cancel();
    super.dispose();
  }

  ShuttleTrackingService service = ShuttleTrackingService();
  AlertBundle alert = AlertBundle();

  void startShuttle(BuildContext context) async {
    try {
      Response response = await service.startShuttleTracking(
        userLocation.latitude,
        userLocation.longitude,
      );
      if (response.statusCode == 200) {
        alert.SnackBarNotify(context, "Shuttle tracking started");
      } else {
        alert.SnackBarNotify(context, "Shuttle tracking not started try again");
      }
    } catch (error) {
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
                      if (rideStarted) ...[
                        userMarker,
                        endPointMarker,
                        firstStopMarker,
                        secondStopMarker,
                        thirdStopMarker,
                        forthStopMarker,
                      ],
                      if (!rideStarted) ...[
                        userMarker,
                        startPointMarker,
                      ],
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
                        getDirection(
                            "${userLocation.latitude},${userLocation.longitude}",
                            "21.1904, 81.2849");

                        checkAndStartRide();
                      }
                    },
                    width: 140,
                    color: const Color(0xFF192B46),
                  ),
                  MapButton(
                    buttonText: isRideComplete ? 'Complete Ride' : 'Start Ride',
                    disabled: !rideStarted,
                    onPressed: () async {
                      if (isRideComplete) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CompleteRide();
                          },
                        );
                      } else if (rideStarted) {
                        startShuttle(context);
                        await getCurrentLocation();
                        final List<LatLng> destinations = [
                          LatLng(21.199617, 81.335226), // First Stop
                          LatLng(21.252625, 81.518494), // Second Stop
                          LatLng(21.251385, 81.629639), // Third Stop
                          LatLng(21.732599, 81.946098), // Fourth Stop
                          LatLng(22.0797, 82.1409), // end Stop
                        ];
                        int currentDestinationIndex = 0;

                        // Function to update the destination and fetch directions.
                        void updateDestinationAndDirections() async {
                          if (currentDestinationIndex < destinations.length) {
                            final LatLng destination =
                                destinations[currentDestinationIndex];

                            // Fetch directions from current location to the destination.
                            await getDirection(
                              "${userLocation.latitude},${userLocation.longitude}",
                              "${destination.latitude},${destination.longitude}",
                            );

                            // Animate the camera to the new destination.
                            final GoogleMapController controller =
                                await _controller.future;
                            controller
                                .animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: userLocation,
                                zoom: 10.0,
                              ),
                            ));

                            currentDestinationIndex++; // Move to the next destination.

                            if (currentDestinationIndex < destinations.length) {
                              // After reaching the current destination, you can update
                              // the next destination's coordinates. For example:
                              // destinations[currentDestinationIndex] = LatLng(newLatitude, newLongitude);
                            }
                          } else {
                            // All destinations reached.
                          }
                        }

                        // Start a timer to update the map every 2 seconds.
                        Timer.periodic(const Duration(seconds: 2), (timer) {
                          updateDestinationAndDirections();
                          if (currentDestinationIndex >= destinations.length) {
                            timer
                                .cancel(); // Stop the timer when all destinations are reached.
                          }
                        });

                        // Initial call to start the process.
                        updateDestinationAndDirections();
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
