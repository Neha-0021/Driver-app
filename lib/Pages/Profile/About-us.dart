import 'package:driver_app/atom/Custom-header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF192B46),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF192B46),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: CustomHeader(
                  headerText: 'About Us',
                  iconColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 25),
                    child: Row(
                      children: [
                        Container(
                          height: 76,
                          width: 76,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFD5DEEE),
                                Color(0xFFF2F4F8),
                              ],
                              stops: [0.0815, 0.9557],
                            ),
                          ),
                          child: const Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'RYD',
                                      style: TextStyle(
                                        fontFamily: 'PublicaSans',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2B70D7),
                                      )),
                                  TextSpan(
                                      text: 'THRU',
                                      style: TextStyle(
                                        fontFamily: 'PublicaSans',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF000000),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('RYDTHRU',
                                  style: TextStyle(
                                    fontFamily: 'PublicaSans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000),
                                  )),
                              const Text(
                                  'Copyright © 2023 RYDTHRU. All Rights Reserved',
                                  style: TextStyle(
                                    fontFamily: 'PublicaSans',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF75879B),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Container(
                                  height: 20,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: const Color(0xFF00BD79)),
                                  child: const Center(
                                    child: Text('Version 1.01',
                                        style: TextStyle(
                                          fontFamily: 'PublicaSans',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFD2DBD6),
                    thickness: 0.5,
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Text(
                          "We are a trusted platform that aims to simplify your shuttle travel experience. Whether you're planning a short trip or a long journey, our user-friendly app provides a seamless and hassle-free way to book shuttle tickets online.",
                          style: textHeadingstyle)),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                          "At our core, we believe in connecting travelers with reliable shuttle operators, ensuring a comfortable and safe journey for all. We have partnered with a wide network of reputable shuttle companies, offering a diverse range of routes and schedules to cater to your travel needs.",
                          style: textHeadingstyle)),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Text(
                          "With our intuitive app interface, you can effortlessly search for available shuttles, compare fares, and choose the most suitable option based on your preferences and budget. We provide detailed information about shuttle amenities, seat availability, and boarding points to help you make an informed decision.",
                          style: textHeadingstyle)),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                          "To enhance your booking experience, we offer secure and convenient payment options, including credit/debit cards and mobile wallets. Rest assured that your personal and financial information is protected by robust security measures.",
                          style: textHeadingstyle)),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Text(
                          "Customer satisfaction is our utmost priority. Our dedicated support team is available 24/7 to assist you with any queries, cancellations, or rescheduling needs. We value your feedback and continuously strive to improve our services based on your suggestions.",
                          style: textHeadingstyle)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const TextStyle textHeadingstyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Color(0xFF75879B),
);