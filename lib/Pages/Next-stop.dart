import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:casa_vertical_stepper/casa_vertical_stepper.dart';
import 'package:driver_app/Molecules/Customer-details.dart';
import 'package:driver_app/atom/header-with-back-button.dart';
import 'package:driver_app/state-management/next-stop.dart';
import 'package:driver_app/utils/bottom-tabbar.dart';

class NextStop extends StatefulWidget {
  const NextStop({Key? key}) : super(key: key);

  @override
  _NextStopState createState() => _NextStopState();
}

class _NextStopState extends State<NextStop> {
  @override
  void initState() {
    super.initState();
    final nextstopState =
        Provider.of<NextStoppageState>(context, listen: false);
    nextstopState.getNextStoppage(
        '64eae1c894173371943c4214', '64eadfb694173371943c414a');
  }

  @override
  Widget build(BuildContext context) {
    final nextstopState = Provider.of<NextStoppageState>(context);
    final stepperList = nextstopState.nextStoppageUserDetails.map((stoppage) {
      final users = stoppage['users'];
      final customerDetailsList = users.map((user) {
        return CustomerDetails(
          name: '${user['firstname']} ${user['lastname']}',
          rideId: 'Ride ID: ${user['_id']}',
        );
      }).toList();

      return StepperStep(
        title: Text(
          stoppage['stoppage_name'],
          style: textHeadingStyle,
        ),
        isExpanded: false,
        leading: SvgPicture.asset('assets/images/svg/drop-s.svg'),
        view: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...customerDetailsList, // Spread operator to unpack the list
          ],
        ),
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
                  child: CasaVerticalStepperView(
                    steps: stepperList,
                    seperatorColor: Colors.transparent,
                    isExpandable: true,
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
