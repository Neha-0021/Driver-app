import 'package:casa_vertical_stepper/casa_vertical_stepper.dart';
import 'package:driver_app/Molecules/Customer-details.dart';

import 'package:driver_app/atom/header-with-back-button.dart';
import 'package:driver_app/state-management/next-stop.dart';
import 'package:driver_app/utils/bottom-tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    final nextStoppageProvider =
        Provider.of<NextStoppageProvider>(context, listen: false);
    nextStoppageProvider.fetchNextStoppages(
        '64a1552d964565929b270bca', '64a154ca964565929b270bc8');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NextStoppageProvider>(
      builder: (context, nextStoppageProvider, child) {
        final stepperList = nextStoppageProvider.nextStoppages
            .asMap()
            .entries
            .map<StepperStep>((entry) {
          final index = entry.key;
          final stoppage = entry.value;

          return StepperStep(
            title: Row(
              children: [
                Text(stoppage['stoppage_name'], style: textHeadingStyle),
                GestureDetector(
                  onTap: () {
                    toggleCustomerDetails(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Icon(
                      selectedIndex == index
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: selectedIndex == index
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
                for (var customer in stoppage['customers'])
                  if (selectedIndex == index)
                    CustomerDetails(
                      name: customer['name'],
                      rideId: 'Ride ID: ${customer['rideId']}',
                    )
                  else
                    Container(),
              ],
            ),
          );
        }).toList();

        return Scaffold(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


