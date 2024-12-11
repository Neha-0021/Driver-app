import 'package:driver_app/state-management/route-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:driver_app/Molecules/Customer-details.dart';
import 'package:driver_app/atom/header-with-back-button.dart';
import 'package:driver_app/state-management/next-stop.dart';
import 'package:driver_app/utils/bottom-tabbar.dart';
import 'package:flutter/services.dart';

class NextStop extends StatefulWidget {
  const NextStop({Key? key}) : super(key: key);

  @override
  _NextStopState createState() => _NextStopState();
}

class _NextStopState extends State<NextStop> {
  @override
  void initState() {
    super.initState();
    final routeState = Provider.of<RouteDetailState>(context, listen: false);
    String routeId = routeState.routeDetails['_id'];
    String stoppageId = routeState.startingPoint['_id'];
    final nextstopState =
        Provider.of<NextStoppageState>(context, listen: false);
    nextstopState.getNextStoppage(routeId, stoppageId);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF192B46),
      ),
    );

    final nextstopState = Provider.of<NextStoppageState>(context);
    final stoppageList = nextstopState.nextStoppageUserDetails.map((stoppage) {
      final users = stoppage['users'];
      final customerDetailsList = users.map((user) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 30), // Add your desired padding values
          child: CustomerDetails(
            name: '${user['firstname']} ${user['lastname']}',
            rideId: 'Ride ID: ${user['_id']}',
          ),
        );
      }).toList();

      return ExpansionTile(
        title: Padding(
          padding:
              const EdgeInsets.only(bottom: 8.0), // Adjust the value as needed
          child: Row(
            children: [
              SvgPicture.asset('assets/images/svg/drop-s.svg'),
              SizedBox(width: 15.0),
              Text(
                stoppage['stoppage_name'],
                style: textHeadingStyle,
              ),
            ],
          ),
        ),
        children: [
          ...customerDetailsList,
        ],
      );
    }).toList();

    return Consumer<NextStoppageState>(
      builder: (context, nextstopState, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderwithBackButton(
                  titleText: 'Next Stop & Customers',
                  subtitleText: 'All details of your customers!',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomBar(),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: stoppageList,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
