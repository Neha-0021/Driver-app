import 'package:driver_app/Pages/History-page.dart';
import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/Pages/Notification-page.dart';
import 'package:driver_app/Pages/Profile/personal-details-page.dart';
import 'package:driver_app/Pages/login.dart';
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
          title: 'RydThru',
          initialRoute: 'Next-stop',
          routes: {
            'personal-details-page': (context) => PersonalDetailPage(),
            'login': (context) => Login(),
            'HistoryPage': (context) => const HistoryPage(),
            'Notification-page': (context) => const NotificationPage(),
            'Next-stop': (context) => const NextStep(),
          },
        ));
  }
}
