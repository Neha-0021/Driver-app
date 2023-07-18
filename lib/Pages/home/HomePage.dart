import 'package:driver_app/Organism/Profile-drawer.dart';
import 'package:driver_app/atom/button.dart';
import 'package:driver_app/atom/home/HomeButton.dart';
import 'package:driver_app/atom/home/HomeButtonn.dart';
import 'package:driver_app/atom/home/HomeHeader.dart';
import 'package:driver_app/atom/home/HomeListCard.dart';

import 'package:driver_app/atom/home/YellowButton.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AlertBundle alert = AlertBundle();

  toggleDrawer() {
    if (mounted) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [ProfileDrawer()],
          ),
        ),
        body: SafeArea(
                child: ListView(children: [
        HomeHeader(openSideDrawer: () => toggleDrawer()),
          Container(
            height: 300,
            child: const Expanded(
              child: WebView(
                initialUrl:
                    'https://app.mappr.tech/v2/hud/documentation/marker',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeButton(
                  buttonText: 'Go to starting Point',
                  onPressed: () {},
                  buttonColor: Color(0xFF192B46),
                ),
                HomeButtonn(
                  buttonText: 'Start Ride',
                  onPressed: () {},
                  buttonColor: Color(0xFF192B46),
                ),
                YellowButton(
                  buttonText: 'Stop Ride',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        const  HomeListCard(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: CustomButton(label: 'View All')),
        ])));
  }
}