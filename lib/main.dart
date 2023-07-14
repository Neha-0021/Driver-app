import 'package:driver_app/Pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver',
      initialRoute: 'login',
      routes: {
        'login': (context) => Login(),
      },
    );
  }
}
