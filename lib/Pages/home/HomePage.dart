import 'package:driver_app/Organism/Profile-drawer.dart';
import 'package:driver_app/atom/home/home-header.dart';
import 'package:driver_app/Molecules/mapper.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AlertBundle alert = AlertBundle();

  toggleDrawer() {
    if (mounted) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  Future<void> requestPermissionHandler() async {
    bool isServiceEnable = await Geolocator.isLocationServiceEnabled();
    print("isService ${isServiceEnable.toString()}");
    if (!isServiceEnable) {
      openSettingPopup();
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      openSettingPopup();
      return;
    }
  }

  void openSettingPopup() {
    alert.showAlertDialogWithAction(
        context,
        "Permission Required",
        'Looks you have not give us location permission. this is nessary for proceeding',
        [
          TextButton(
              onPressed: () => openAppSettings(),
              child: const Text("Open Settings")),
        ],
        false);
  }

  @override
  void initState() {
    super.initState();
    requestPermissionHandler();
  }

  @override
  Widget build(BuildContext context) {
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
