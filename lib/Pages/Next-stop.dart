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
  int selectedIndex = -1;

  void toggleCustomerDetails(int index) {
    setState(() {
      selectedIndex = selectedIndex == index ? -1 : index;
    });
  }

  @override
  void initState() {
    super.initState();
    final nextstopState =
        Provider.of<NextStoppageState>(context, listen: false);
    nextstopState.getNextStoppage(
        '64a1552d964565929b270bca', '64a154ca964565929b270bc8');
  }

  @override
  Widget build(BuildContext context) {
    final nextstopState = Provider.of<NextStoppageState>(context);
    final stepperList = nextstopState.nextStoppageDetails.map((stoppage) {
      return StepperStep(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stoppage['stoppage_name'],
              style: textHeadingStyle,
            ),
            GestureDetector(
              onTap: () {
                toggleCustomerDetails(
                    nextstopState.nextStoppageDetails.indexOf(stoppage));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 170),
                child: Icon(
                  selectedIndex ==
                          nextstopState.nextStoppageDetails.indexOf(stoppage)
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: selectedIndex ==
                          nextstopState.nextStoppageDetails.indexOf(stoppage)
                      ? Colors.black
                      : const Color(0XFF75879B),
                ),
              ),
            ),
          ],
        ),
        leading: SvgPicture.asset('assets/images/svg/drop-s.svg'),
        view: Column(
          children: [
            if (selectedIndex ==
                nextstopState.nextStoppageDetails.indexOf(stoppage))
              CustomerDetails(
                name:
                    '${nextstopState.userDetails[0]['firstname']} ${nextstopState.userDetails[0]['lastname']}',
                rideId: 'Ride ID: ${nextstopState.userDetails[0]['_id']}',
              )
            else
              Container(),
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
                          builder: (context) => const BottomBar()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: CasaVerticalStepperView(
                    steps: stepperList,
                    seperatorColor: Colors.transparent,
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
