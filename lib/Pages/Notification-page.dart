import 'package:driver_app/Molecules/Notification-card.dart';
import 'package:driver_app/atom/history-notification-header.dart';
import 'package:driver_app/state-management/notification-state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    final notificationState =
        Provider.of<DriverNotificationState>(context, listen: false);
    notificationState.getDriverNotification();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF192B46),
      ),
    );

    return Consumer<DriverNotificationState>(
      builder: (context, notificationState, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HistoryNotificationHeader(
                    Titletext: 'Notifications',
                    subtitletext:
                        'Stay up to date, get notify with every updates!'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notificationState.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notificationState.notifications[index];
                    return NotificationCard(notification: notification);
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notificationState.viewedNotifications.length,
                  itemBuilder: (context, index) {
                    final notification =
                        notificationState.viewedNotifications[index];
                    return NotificationCard(notification: notification);
                  },
                ),
                notificationState.notifications.isEmpty
                    ? GestureDetector(
                        onTap: () =>
                            {notificationState.getViewedDriverNotification()},
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              notificationState.viewedNotifications.isEmpty
                                  ? "Show Older Notification"
                                  : "",
                            )))
                    : const Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
