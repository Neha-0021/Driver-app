import 'package:casa_vertical_stepper/casa_vertical_stepper.dart';
import 'package:driver_app/Molecules/Customer-details.dart';

import 'package:driver_app/atom/header-with-back-button.dart';
import 'package:driver_app/state-management/next-stop.dart';
import 'package:driver_app/utils/bottom-tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NextStop extends StatefulWidget {
  const NextStop({super.key});

  @override
  _NextStopState createState() => _NextStopState();
}

class _NextStopState extends State<NextStop> {
  List<bool> showCustomerDetailsList = List.filled(7, false);

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
    nextstopState.getNextStoppage();
  }

  @override
  Widget build(BuildContext context) {
    final stepperList = [
      StepperStep(
        title: Row(
          children: [
            const Text('Shri Nagar Mills Bus Stop', style: textHeadingStyle),
            GestureDetector(
              onTap: () {
                toggleCustomerDetails(0);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Icon(
                  selectedIndex == 0
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: selectedIndex == 0
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
            selectedIndex == 0
                ? CustomerDetails(name: 'Rahul Acharya', rideId: 'Ride ID: 110')
                : Container(),
            selectedIndex == 0
                ? CustomerDetails(name: 'John Doe', rideId: 'Ride ID: 110')
                : Container(),
          ],
        ),
      ),
      StepperStep(
        title: Row(
          children: [
            const Text('Shri Nagar Mills Bus Stop', style: textHeadingStyle),
            GestureDetector(
              onTap: () {
                toggleCustomerDetails(1);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Icon(
                  selectedIndex == 1
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: selectedIndex == 1
                      ? Colors.black
                      : const Color(0XFF75879B),
                ),
              ),
            ),
          ],
        ),
        leading: SvgPicture.asset('assets/images/svg/drop.svg'),
        view: Column(
          children: [
            selectedIndex == 1
                ? CustomerDetails(name: 'Rahul Acharya', rideId: 'Ride ID: 110')
                : Container(),
            selectedIndex == 1
                ? CustomerDetails(name: 'John Doe', rideId: 'Ride ID: 110')
                : Container(),
          ],
        ),
      ),
      StepperStep(
        title: Row(
          children: [
            const Text('Shri Nagar Mills Bus Stop', style: textHeadingStyle),
            GestureDetector(
              onTap: () {
                toggleCustomerDetails(2);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Icon(
                  selectedIndex == 2
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: selectedIndex == 2
                      ? Colors.black
                      : const Color(0XFF75879B),
                ),
              ),
            ),
          ],
        ),
        leading: SvgPicture.asset('assets/images/svg/drop.svg'),
        view: Column(
          children: [
            selectedIndex == 2
                ? CustomerDetails(name: 'Rahul Acharya', rideId: 'Ride ID: 110')
                : Container(),
            selectedIndex == 2
                ? CustomerDetails(name: 'John Doe', rideId: 'Ride ID: 110')
                : Container(),
          ],
        ),
      ),
      StepperStep(
        title: Row(
          children: [
            const Text('Shri Nagar Mills Bus Stop', style: textHeadingStyle),
            GestureDetector(
              onTap: () {
                toggleCustomerDetails(3);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Icon(
                  selectedIndex == 3
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: selectedIndex == 3
                      ? Colors.black
                      : const Color(0XFF75879B),
                ),
              ),
            ),
          ],
        ),
        leading: SvgPicture.asset('assets/images/svg/drop.svg'),
        view: Column(
          children: [
            selectedIndex == 3
                ? CustomerDetails(name: 'Rahul Acharya', rideId: 'Ride ID: 110')
                : Container(),
            selectedIndex == 3
                ? CustomerDetails(name: 'John Doe', rideId: 'Ride ID: 110')
                : Container(),
          ],
        ),
      ),
      StepperStep(
        title: Row(
          children: [
            const Text('Shri Nagar Mills Bus Stop', style: textHeadingStyle),
            GestureDetector(
              onTap: () {
                toggleCustomerDetails(4);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Icon(
                  selectedIndex == 4
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: selectedIndex == 4
                      ? Colors.black
                      : const Color(0XFF75879B),
                ),
              ),
            ),
          ],
        ),
        leading: SvgPicture.asset('assets/images/svg/drop.svg'),
        view: Column(
          children: [
            selectedIndex == 4
                ? CustomerDetails(name: 'Rahul Acharya', rideId: 'Ride ID: 110')
                : Container(),
            selectedIndex == 4
                ? CustomerDetails(name: 'John Doe', rideId: 'Ride ID: 110')
                : Container(),
          ],
        ),
      ),
      StepperStep(
        title: Row(
          children: [
            const Text('Shri Nagar Mills Bus Stop', style: textHeadingStyle),
            GestureDetector(
              onTap: () {
                toggleCustomerDetails(5);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Icon(
                  selectedIndex == 5
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: selectedIndex == 5
                      ? Colors.black
                      : const Color(0XFF75879B),
                ),
              ),
            ),
          ],
        ),
        leading: SvgPicture.asset('assets/images/svg/drop.svg'),
        view: Column(
          children: [
            selectedIndex == 5
                ? CustomerDetails(name: 'Rahul Acharya', rideId: 'Ride ID: 110')
                : Container(),
            selectedIndex == 5
                ? CustomerDetails(name: 'John Doe', rideId: 'Ride ID: 110')
                : Container(),
          ],
        ),
      ),
      StepperStep(
        title: Row(
          children: [
            const Text('Shri Nagar Mills Bus Stop', style: textHeadingStyle),
            GestureDetector(
              onTap: () {
                toggleCustomerDetails(6);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Icon(
                  selectedIndex == 6
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: selectedIndex == 6
                      ? Colors.black
                      : const Color(0XFF75879B),
                ),
              ),
            ),
          ],
        ),
        leading: SvgPicture.asset('assets/images/svg/location.svg'),
        view: Column(
          children: [
            selectedIndex == 6
                ? CustomerDetails(name: 'Rahul Acharya', rideId: 'Ride ID: 110')
                : Container(),
            selectedIndex == 6
                ? CustomerDetails(name: 'John Doe', rideId: 'Ride ID: 110')
                : Container(),
          ],
        ),
      ),
    ];
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
                      MaterialPageRoute(builder: (context) => const BottomBar()),
                    );
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: CasaVerticalStepperView(
                      steps: stepperList,
                      seperatorColor: Colors.transparent,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
