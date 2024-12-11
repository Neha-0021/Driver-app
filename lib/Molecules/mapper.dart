import 'dart:async';
import 'package:custom_marker/marker_icon.dart';

import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/atom/Button.dart';
import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';

import 'package:driver_app/atom/home/HomeListCard.dart';
import 'package:driver_app/atom/home/MapButton.dart';
import 'package:driver_app/service/mapper/map.dart';
import 'package:driver_app/service/route/route.dart';
import 'package:driver_app/service/stop-ride.dart';

import 'package:driver_app/state-management/profile-state.dart';
import 'package:driver_app/state-management/route-state.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:driver_app/utils/distance.dart';
import 'package:driver_app/utils/storage.dart';
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
  Timer? locationUpdateTimer;
  MapperMap map = MapperMap();

  late GoogleMapController mapController;

  BitmapDescriptor? userIcon;

  bool fullScreen = false;
  bool isRideCompleted = false;
  DistanceUtils distanceUtils = DistanceUtils();
  PhoneStorage phoneStorage = PhoneStorage();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> getCurrentLocation() async {
    final locationProvider =
        Provider.of<RouteDetailState>(context, listen: false);

    await locationProvider.getCurrentLocation();

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
        locationProvider.updateUserMarker(Marker(
          markerId: const MarkerId("userMarker"),
          icon: icon,
          position: locationProvider.userLocation,
        ));
      });
      if (_controller.isCompleted) {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
            CameraUpdate.newLatLng(locationProvider.userLocation));
      }
    }
  }

  void toggleMapSize() {
    setState(() {
      fullScreen = !fullScreen;
    });
  }

  final RouteDetailService service = RouteDetailService();
  AlertBundle alert = AlertBundle();
  StopRideService stop = StopRideService();

  @override
  void initState() {
    super.initState();

    final routeState = Provider.of<RouteDetailState>(context, listen: false);
    getCurrentLocation();

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
    LatLng userLocation = Provider.of<RouteDetailState>(context).userLocation;

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
                            if (routeState.rideStarted) ...[
                              routeState.userMarker,
                              ...routeState.stoppageMarkers,
                            ],
                            if (!routeState.rideStarted) ...[
                              routeState.userMarker,
                              routeState.startPointMarker,
                            ],
                          },
                          polylines: routeState.routeCoordinates,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          }),
                      if (routeState.isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
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
                      onPressed: () async {
                        routeState.getDirections(
                            "${userLocation.latitude},${userLocation.longitude}",
                            "${routeState.startingPoint["latitude"]},${routeState.startingPoint["longitude"]}");
                        routeState.checkAndStartRide(context);
                      },
                      width: 140,
                      color: const Color(0xFF192B46),
                    ),
                    MapButton(
                      buttonText: 'Start Ride',
                      disabled: !routeState.rideStarted,
                      onPressed: () async {
                        if (routeState.rideStarted) {
                          Timer.periodic(const Duration(seconds: 5), (timer) {
                            routeState.startShuttle();
                            routeState.updateShuttle();
                          });
                          List<LatLng> destinations = [];
                          for (var stoppage in routeState.stoppageWithDetails) {
                            double latitude =
                                double.parse(stoppage["stoppage"]["latitude"]);
                            double longitude =
                                double.parse(stoppage["stoppage"]["longitude"]);
                            LatLng location = LatLng(latitude, longitude);
                            destinations.add(location);
                          }
                          int currentDestinationIndex = 0;
                          void updateDestinationAndDirections() async {
                            if (currentDestinationIndex < destinations.length) {
                              final LatLng destination =
                                  destinations[currentDestinationIndex];
                              // Fetch directions from current location to the destination.
                              await routeState.getDirections(
                                "${userLocation.latitude},${userLocation.longitude}",
                                "${destination.latitude},${destination.longitude}",
                              );
                              // Animate the camera to the new destination.

                              String destinationdistaion = await distanceUtils
                                  .getCurrentLocationAndCalculateDistance(
                                destination.latitude,
                                destination.longitude,
                              );
                              String distanceString = destinationdistaion
                                  .replaceAll(RegExp(r'[^0-9.]'), '');
                              double? distance =
                                  double.tryParse(distanceString);

                              Timer.periodic(const Duration(seconds: 5),
                                  (timer) {
                                if (distance != null && distance <= 10.0) {
                                  currentDestinationIndex++;
                                  if (currentDestinationIndex ==
                                      destinations.length) {
                                    routeState.stopRide();
                                  }
                                  updateDestinationAndDirections();
                                }
                              });
                            }
                          }

                          updateDestinationAndDirections();
                        }
                      },
                      width: 110,
                      color: const Color(0xFF192B46),
                    ),
                    MapButton(
                      buttonText: 'Stop Ride',
                      disabled: !routeState.rideStarted,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const StopRide();
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
                              routeState.rideStarted
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
                    onPressed: () async {
                      await Navigator.push(
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
