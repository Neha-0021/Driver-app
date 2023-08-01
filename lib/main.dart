import 'package:driver_app/Pages/History-page.dart';
import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/Pages/Notification-page.dart';
import 'package:driver_app/Pages/Driver/DriverRating.dart';
import 'package:driver_app/Pages/Profile/personal-details-page.dart';
import 'package:driver_app/Pages/login.dart';
import 'package:driver_app/state-management/Driver-Rating-state.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/state-management/notification-state.dart';

import 'package:driver_app/state-management/profile-state.dart';
import 'package:driver_app/utils/bottom-tabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/home/HomePage.dart';
import 'state-management/history-state.dart';

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
          ChangeNotifierProvider(create: (context) => DriverRatingState()),
          ChangeNotifierProvider(create: (context) => DriverHistoryState()),
          ChangeNotifierProvider(
              create: (context) => DriverNotificationState()),
        ],
        child: MaterialApp(
          title: 'DRIVER',
          initialRoute: 'HomePage',
          routes: {
            'personal-details-page': (context) => PersonalDetailPage(),
            'DriverRating': (context) => const DriverRating(),
            'login': (context) => Login(),
            'HistoryPage': (context) => const HistoryPage(),
            'Notification-page': (context) => const NotificationPage(),
            'Next-stop': (context) => const NextStop(),
            'HomePage': (context) => const HomePage(),
            'bottom-tabbar': (context) => const BottomBar(),
          },
        ));
  }
}
