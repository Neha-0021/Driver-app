import 'package:driver_app/Organism/Profile-drawer.dart';
import 'package:driver_app/Pages/Driver/DriverRating.dart';
import 'package:driver_app/Pages/Profile/personal-details-page.dart';
import 'package:driver_app/Pages/login.dart';
import 'package:driver_app/atom/Map/MapScreen.dart';
import 'package:driver_app/atom/Pop-Up/CompleteRide.dart';
import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/state-management/profile-state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (content) => HomeState()),
          ChangeNotifierProvider(create: (context) => ProfileState()),
        ],
        child: MaterialApp(
          title: 'DRIVER',
          initialRoute: 'MapScreen',
          routes: {
            'personal-details-page': (context) => PersonalDetailPage(),
            'DriverRating': (context) => DriverRating(),
            'login': (context) => Login(),
            'MapScreen' :(context) => MapScreen(),
            //'Profile-drawer':(context) => ProfileDrawer(),
            //'CompleteRide' :(context) => CompleteRide(),
            //'Stop-ride': (context) => StopRide(),
          },
        ));
  }
}
