import 'package:driver_app/Molecules/history-card.dart';
import 'package:driver_app/atom/history-notification-header.dart';
import 'package:driver_app/atom/history/no-history.dart';
import 'package:driver_app/state-management/history-state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> upcomingBookings = [];

  @override
  void initState() {
    super.initState();
    final historyState =
        Provider.of<DriverHistoryState>(context, listen: false);
    historyState.getDriverCompleteHistory();
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF192B46),
      ),
    );
    return Consumer<DriverHistoryState>(
      builder: (context, historyState, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HistoryNotificationHeader(
                Titletext: 'History',
                subtitletext: 'Check your ride history here!',
              ),
              historyState.completeHistory.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: historyState.completeHistory.length,
                      itemBuilder: (context, index) {
                        final history = historyState.completeHistory[index];
                        return HistoryCard(data: history);
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20), child: NoHistory()),
            ],
          ),
        ),
      ),
    );
  }
}
