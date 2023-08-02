import 'package:driver_app/Pages/History-page.dart';
import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/Pages/Notification-page.dart';
import 'package:driver_app/Pages/Driver/DriverRating.dart';
import 'package:driver_app/Pages/Profile/personal-details-page.dart';
import 'package:driver_app/Pages/login.dart';
import 'package:driver_app/notification-handler.dart';
import 'package:driver_app/state-management/Driver-Rating-state.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/state-management/notification-state.dart';

import 'package:driver_app/state-management/profile-state.dart';
import 'package:driver_app/utils/bottom-tabbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/home/HomePage.dart';
import 'state-management/history-state.dart';



Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  
  @override
  State<StatefulWidget> createState() {
    return MyAppComponent();
  }
}

class MyAppComponent extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeNotificationService();
  }

  void initializeNotificationService() async {
    // Create an instance of the NotificationService class
    NotificationHandler notificationService = NotificationHandler();

    // Get the FCM token using the notification service
    String? token = await notificationService.getFcmToken();
    if (token != "") {
      print('FCM Token: $token');
    } else {
      print('Unable to get FCM token.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (content) => HomeState()),
          ChangeNotifierProvider(create: (context) => ProfileState()),
          ChangeNotifierProvider(create: (context) => DriverRatingState()),
          ChangeNotifierProvider(create: (context) => DriverHistoryState()),
          ChangeNotifierProvider(create: (context) => DriverNotificationState()),
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
            'Next-stop': (context) => const NextStop(),
            'HomePage': (context) => const HomePage(),
            'bottom-tabbar': (context) => const BottomBar(),
          },
        ));
  }
}
