import 'dart:async';
import 'package:custom_marker/marker_icon.dart';
import 'package:dio/dio.dart';
import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/atom/Button.dart';
import 'package:driver_app/atom/Pop-Up/complete.dart';
import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';
import 'package:driver_app/atom/home/HomeListCard.dart';
import 'package:driver_app/atom/home/MapButton.dart';
import 'package:driver_app/service/mapper/map.dart';
import 'package:driver_app/state-management/profile-state.dart';
import 'package:driver_app/state-management/route-state.dart';
import 'package:driver_app/utils/distance.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Mapper extends StatefulWidget {
  const Mapper({Key? key}) : super(key: key);

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
  bool isLoading = true;
  bool fullScreen = false;
  bool isRideCompleted = false;
  DistanceUtils distanceUtils = DistanceUtils();

  bool rideStarted = false;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Marker userMarker = const Marker(
    markerId: MarkerId("userMarket"),
  );

  Marker startPointMarker = const Marker(
    markerId: MarkerId("startPointMarker"),
  );

  List<Marker> stoppageMarkers = [];

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;
    if (mounted) {
      final stateCall = Provider.of<ProfileState>(context, listen: false);
      String profilePhoto = stateCall.driverData['profile_photo'];
      final icon = await MarkerIcon.downloadResizePictureCircle(
        profilePhoto,
        size: 120,
        addBorder: true,
        borderColor: Colors.white,
        borderSize: 30,
      );

      setState(() {
        userLocation = LatLng(latitude, longitude);
        userMarker = Marker(
          markerId: const MarkerId("userMarker"),
          icon: icon,
          position: userLocation,
        );

        isLoading = false;
      });

      // Update the camera position to the user's location
      if (_controller.isCompleted) {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLng(userLocation));
      }
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
      setState(() {
        final routeState =
            Provider.of<RouteDetailState>(context, listen: false);
        double startingPointLatitude =
            double.parse(routeState.startingPoint["latitude"]);
        double startingPointLongitude =
            double.parse(routeState.startingPoint["longitude"]);
        startPointMarker = Marker(
            markerId: const MarkerId("startPointMarker"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(startingPointLatitude, startingPointLongitude));
        for (var stoppage in routeState.stoppageWithDetails) {
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
      });
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

  void checkAndStartRide(BuildContext context) async {
    final routeState = Provider.of<RouteDetailState>(context, listen: false);
    double startingPointLatitude =
        double.parse(routeState.startingPoint["latitude"]);
    double startingPointLongitude =
        double.parse(routeState.startingPoint["longitude"]);
    String distanceString =
        await distanceUtils.getCurrentLocationAndCalculateDistance(
            startingPointLatitude, startingPointLongitude);
    String startingpoint = distanceString.replaceAll(RegExp(r'[^0-9.]'), '');
    double? distance = double.tryParse(startingpoint);
    if (distance != null && distance <= 10.0) {
      DateTime currentTime = DateTime.now();
      DateTime startingTime =
          DateFormat('hh:mm a').parse(routeState.routeDetails["timing_from"]);
      startingTime = DateTime(currentTime.year, currentTime.month,
          currentTime.day, startingTime.hour, startingTime.minute);
      if (currentTime.isAfter(startingTime)) {
        startingTime = startingTime.add(const Duration(days: 1));
      }
      Duration timeDifference = startingTime.difference(currentTime);
      if (timeDifference.inMinutes <= 10) {
        setState(() {
          rideStarted = true;
        });
      }
    }
  }

  void toggleMapSize() {
    setState(() {
      fullScreen = !fullScreen;
    });
  }

  @override
  void initState() {
    super.initState();
    final routeState = Provider.of<RouteDetailState>(context, listen: false);
    String currentDate = DateTime.now().toLocal().toString().split(' ')[0];
    routeState.getRouteDetailsByDriver(currentDate);
    locationUpdateTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      getCurrentLocation();
    });
  }

  @override
  void dispose() {
    locationUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteDetailState>(
      builder: (context, routeState, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  height: fullScreen ? MediaQuery.of(context).size.height : 390,
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: userLocation,
                          zoom: 15.0,
                        ),
                        markers: {
                          if (rideStarted) ...[
                            userMarker,
                            ...stoppageMarkers,
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
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            fullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              fullScreen = !fullScreen;
                            });
                          },
                        ),
                      ),
                      if (isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !fullScreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MapButton(
                      buttonText: 'Go to starting Point',
                      onPressed: () {
                        getDirection(
                            "${userLocation.latitude},${userLocation.longitude}",
                            "${routeState.startingPoint["latitude"]},${routeState.startingPoint["longitude"]}");
                        checkAndStartRide(context);
                      },
                      width: 140,
                      color: const Color(0xFF192B46),
                    ),
                    MapButton(
                      buttonText:
                          isRideCompleted ? 'Complete Ride' : 'Start Ride',
                      disabled: !rideStarted,
                      onPressed: () async {
                        if (rideStarted) {
                          if (isRideCompleted) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CompleteRide();
                              },
                            );
                          } else {
                            routeState.startShuttleTracking(
                              userLocation.latitude,
                              userLocation.longitude,
                            );
                            String id = routeState.starttracking["_id"];
                            routeState.updateShuttleTracking(
                                "${userLocation.latitude},${userLocation.longitude}",
                                id);
                            setState(() {
                              isLoading = true;
                            });

                            List<LatLng> destinations = [];
                            for (var stoppage
                                in routeState.stoppageWithDetails) {
                              double latitude = double.parse(
                                  stoppage["stoppage"]["latitude"]);
                              double longitude = double.parse(
                                  stoppage["stoppage"]["longitude"]);
                              LatLng location = LatLng(latitude, longitude);
                              destinations.add(location);
                            }
                            int currentDestinationIndex = 0;
                            void updateDestinationAndDirections() async {
                              if (currentDestinationIndex <
                                  destinations.length) {
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
                                controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: userLocation,
                                    zoom: 15.0,
                                  ),
                                ));
                                String destinationdistaion = await distanceUtils
                                    .getCurrentLocationAndCalculateDistance(
                                  destination.latitude,
                                  destination.longitude,
                                );
                                String distanceString = destinationdistaion
                                    .replaceAll(RegExp(r'[^0-9.]'), '');
                                double? distance =
                                    double.tryParse(distanceString);

                                if (distance != null &&
                                    (distance <= 10.0 ||
                                        currentDestinationIndex ==
                                            destinations.length - 1)) {
                                  isRideCompleted = true;
                                  setState(() {});
                                }

                                Timer.periodic(const Duration(seconds: 2),
                                    (timer) {
                                  if (distance != null && distance <= 10.0) {
                                    currentDestinationIndex++;
                                    if (currentDestinationIndex ==
                                        destinations.length) {
                                      isRideCompleted = true;
                                    }
                                    updateDestinationAndDirections();
                                  }
                                });
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }

                            updateDestinationAndDirections();
                          }
                        }
                      },
                      width: 110,
                      color: const Color(0xFF192B46),
                    ),
                    MapButton(
                      buttonText: 'Stop Ride',
                      disabled: !rideStarted,
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
              ),
              Visibility(
                visible: !fullScreen,
                child: Padding(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              rideStarted
                                  ? 'Next Stop & Customers'
                                  : 'Total People to Pickup • ${routeState.totalUsers} Customers',
                              style: const TextStyle(
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
              ),
              Visibility(
                visible: !fullScreen,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: routeState.stoppageWithDetails.length,
                  itemBuilder: (context, index) {
                    final home = routeState.stoppageWithDetails[index];

                    return HomeListCard(data: home);
                  },
                ),
              ),
              Visibility(
                visible: !fullScreen,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: CustomButton(
                    label: 'View All',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NextStop()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
