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
import 'package:driver_app/state-management/profile-state.dart';
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

  Marker userMarker = const Marker(markerId: MarkerId("userMarker"));

  Marker startPointMarker = const Marker(
    markerId: MarkerId("startPointMarker"),
  );

  Marker destinationMark = const Marker(
    markerId: MarkerId("destinationMarker"),
  );

  List<Marker> stoppageMarkers = [];

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
        final routeState =
            Provider.of<RouteDetailState>(context, listen: false);
        double startingPointLatitude =
            double.parse(routeState.startingPoint["latitude"]);
        double startingPointLongitude =
            double.parse(routeState.startingPoint["longitude"]);

        userLocation = LatLng(latitude, longitude);
        userMarker = Marker(
            markerId: const MarkerId("userMarker"),
            icon: BitmapDescriptor.defaultMarker,
            position: userLocation);
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

  bool rideStarted = false;

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
    if (distance != null && distance <= 703530.48) {
      setState(() {
        rideStarted = true;
      });
    }
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

  bool fullScreen = false;
  bool isRideCompleted = false;
  bool isLoading = false;

  void toggleMapSize() {
    setState(() {
      fullScreen = !fullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteDetailState>(
      builder: (context, routeState, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: fullScreen
                          ? MediaQuery.of(context).size.height
                          : 390.0,
                      child: Stack(
                        children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
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
                          // Loading Indicator (conditionally visible)
                          Visibility(
                            visible:
                                isLoading, // Set this flag based on your logic
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: IconButton(
                      icon: Icon(
                        fullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                        size: 32,
                      ),
                      onPressed: () {
                        toggleMapSize();
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: !fullScreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MapButton(
                      buttonText: 'Go to starting Point',
                      onPressed: () async {
                        setState(() {
                          isLoading =
                              true; // Set loading to true when button is pressed
                        });

                        await getCurrentLocation();
                        final GoogleMapController controller =
                            await _controller.future;
                        if (userLocation.latitude != 0.0 &&
                            userLocation.longitude != 0.0) {
                          controller
                              .animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: userLocation,
                              zoom: 10.0,
                            ),
                          ));
                          getDirection(
                              "${userLocation.latitude},${userLocation.longitude}",
                              "${routeState.startingPoint["latitude"]},${routeState.startingPoint["longitude"]}");

                          // After fetching direction, set loading to false
                          setState(() {
                            isLoading = false;
                          });
                        }
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
                            startShuttle(context);
                            setState(() {
                              isLoading = true;
                            });
                            await getCurrentLocation();
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
                                    target: destination,
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
                                    (distance <= 704530.48 ||
                                        currentDestinationIndex ==
                                            destinations.length - 1)) {
                                  isRideCompleted = true;
                                  setState(() {});
                                }

                                Timer.periodic(const Duration(seconds: 2),
                                    (timer) {
                                  if (distance != null &&
                                      distance <= 704530.48) {
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StopRide();
                          },
                        );
                      },
                      color: const Color(0xFFECB21E),
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
