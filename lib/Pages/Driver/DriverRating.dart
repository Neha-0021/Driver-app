import 'package:driver_app/atom/Driver/DriverContainer.dart';
import 'package:driver_app/atom/Driver/Driverlist-card.dart';
import 'package:driver_app/atom/Driver/HeaderWith-BackButton.dart';
import 'package:flutter/material.dart';

class DriverRating extends StatelessWidget {
  const DriverRating({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderwithBackButton(
                Titletext: 'Driver Rating',
                subtitletext: 'Check what your customers say about you!',
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: DriverContainer(
                        titleText: 'Total Customer',
                        imagePath: 'assets/images/svg/Vector.svg',
                        subtitleText: '20',
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: DriverContainer(
                        titleText: 'Average Ratings',
                        imagePath: 'assets/images/svg/Vectorv.svg',
                        subtitleText: '3.2',
                      )),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Container(
                decoration: const BoxDecoration(color: Color(0xFF6B7B8E)),
                child: const Row(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Text(
                          'Customer Name & Ratings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Publica Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ],
                ),
              ),
              const DriverListCard(
                imagePathProfile: 'assets/images/Driverimage.png',
                offerText: 'Rahul Chorasiya',
                subText: 'Ahmedabad - Kanpur • Sun 14 May',
                imagePath: 'assets/images/svg/Star.svg',
                subTitleText: '4.0',
              ),
              const DriverListCard(
                imagePathProfile: 'assets/images/Driverrating1.png',
                offerText: 'Chandani Chopra',
                subText: 'Ahmedabad - Kanpur • Sun 14 May',
                imagePath: 'assets/images/svg/Stars.svg',
                subTitleText: '3.1',
              ),
              const DriverListCard(
                imagePathProfile: 'assets/images/Driverrating2.png',
                offerText: 'Chinmay Jivani',
                subText: 'Ahmedabad - Kanpur • Sun 14 May',
                imagePath: 'assets/images/svg/Stars.svg',
                subTitleText: '3.4',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
