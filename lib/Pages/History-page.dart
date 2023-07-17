import 'package:driver_app/Molecules/history-card.dart';
import 'package:driver_app/atom/history-notification-header.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HistoryNotificationHeader(
                Titletext: 'History',
                subtitletext: 'Check your ride history here!'),
            HistoryCard(),
          ],
        ),
      ),
    );
  }
}
