import 'package:driver_app/Molecules/driver-list-card.dart';
import 'package:driver_app/atom/Driver/DriverContainer.dart';
import 'package:driver_app/atom/Driver/HeaderWith-BackButton.dart';
import 'package:driver_app/state-management/Driver-Rating-state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DriverRating extends StatefulWidget {
  const DriverRating({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DriverRatingState createState() => _DriverRatingState();
}

class _DriverRatingState extends State<DriverRating> {
  @override
  void initState() {
    super.initState();
    final driverRatingState =
        Provider.of<DriverRatingState>(context, listen: false);
    driverRatingState.getDriverRatingByBookingId('64a1583d964565929b270bf7');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF192B46),
      ),
    );

    return Consumer<DriverRatingState>(
      builder: (context, driverRatingState, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderwithBackButton(
                  Titletext: 'Driver Rating',
                  subtitletext: 'Check what your customers say about you!',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DriverContainer(
                        titleText: 'Total Customer',
                        imagePath: 'assets/images/svg/Vector.svg',
                        subtitleText: '20',
                      ),
                      DriverContainer(
                        titleText: 'Average Ratings',
                        imagePath: 'assets/images/svg/Vectorv.svg',
                        subtitleText: '3.2',
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Color(0xFF6B7B8E)),
                  child: const Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Text(
                            'Customer Name & Ratings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'PublicaSans',
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: driverRatingState.driverRating.length,
                    itemBuilder: (context, index) {
                      final driver = driverRatingState.driverRating[index];
                      return DriverListCard(data: driver);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
