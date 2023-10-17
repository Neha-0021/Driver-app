import 'dart:io';

import 'package:driver_app/Organism/Profile-drawer.dart';
import 'package:driver_app/atom/home/homeheader.dart';
import 'package:driver_app/Molecules/mapper.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool permissionPopupShown = false;
  bool permissionRequested = false;

  AlertBundle alert = AlertBundle();

  toggleDrawer() {
    if (mounted) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  Future<void> requestPermissionHandler() async {
    if (permissionRequested) {
      return;
    }
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!permissionPopupShown) {
        openSettingPopup();
        permissionPopupShown = true;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      permissionRequested = true;
      if (permission == LocationPermission.denied) {
        if (!permissionPopupShown) {
          openSettingPopup();
          permissionPopupShown = true;
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!permissionPopupShown) {
        openSettingPopup();
        permissionPopupShown = true;
      }
    }
  }

  void openSettingPopup() {
    alert.showAlertDialogWithAction(
        context,
        "Permission Required",
        "To enhance your travel experience, granting location access allows us to help you identify your nearest boarding point. Your privacy is our utmost concern, and we at RydThru take rigorous measures to safeguard it. Please note that without it, all app features are restricted. Your location permission is crucial for personalized, optimal travel solutions.",
        [
          TextButton(
              onPressed: () => {Navigator.pop(context), openAppSettings()},
              child: const Text("Open Settings")),
          TextButton(onPressed: () => {exit(0)}, child: const Text("Exit")),
        ],
        false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    requestPermissionHandler();
  }

  @override
  void dispose() {
    // Add this line to remove the observer when the widget is disposed
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      requestPermissionHandler();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF192B46),
      ),
    );
    return Consumer<HomeState>(
      builder: (context, homeState, child) => Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [ProfileDrawer()],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              HomeHeader(
                openSideDrawer: () => toggleDrawer(),
              ),
              const Expanded(
                child: Mapper(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
