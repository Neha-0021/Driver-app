import 'package:driver_app/Pages/History-page.dart';
import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/Pages/Notification-page.dart';
import 'package:driver_app/Pages/Driver/DriverRating.dart';
import 'package:driver_app/Pages/Profile/personal-details-page.dart';
import 'package:driver_app/Pages/login.dart';
import 'package:driver_app/atom/BackgroundFetch/get_lat_long_address.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/state-management/notification-state.dart';
import 'package:driver_app/state-management/profile-state.dart';
import 'package:driver_app/utils/bottom-tabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/home/HomePage.dart';

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
          ChangeNotifierProvider(create: (context) => NotificationState()),
        ],
        child: MaterialApp(
          title: 'DRIVER',
          initialRoute: 'login',
          routes: {
            'personal-details-page': (context) => PersonalDetailPage(),
            'DriverRating': (context) => const DriverRating(),
            
            'login': (context) => Login(),
            'HistoryPage': (context) => const HistoryPage(),
            'Notification-page': (context) => const NotificationPage(),
            'Next-stop': (context) => const NextStep(),
            'HomePage': (context) => const HomePage(),
            'bottom-tabbar': (context) => const BottomBar(),
            
          },
        ));
  }
}
