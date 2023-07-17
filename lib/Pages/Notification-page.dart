import 'package:driver_app/Molecules/Notification-card.dart';
import 'package:driver_app/atom/history-notification-header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF192B46),
      ),
    );

    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HistoryNotificationHeader(
                  Titletext: 'Notifications',
                  subtitletext:
                      'Stay up to date, get notify with every updates!'),
              NotificationCard(),
            ],
          ),
        ),
      ),
    );
  }
}
