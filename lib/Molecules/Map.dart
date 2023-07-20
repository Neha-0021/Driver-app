import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';
import 'package:driver_app/atom/button.dart';
import 'package:driver_app/atom/home/HomeListCard.dart';
import 'package:driver_app/atom/home/MapButton.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        height: 300,
        child: const WebView(
          initialUrl: 'https://app.mappr.tech/v2/hud/documentation/marker',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MapButton(
                buttonText: 'Go to starting Point',
                onPressed: () {},
                width: 140,
                color: const Color(0xFF192B46)),
            MapButton(
                buttonText: 'Complete Ride',
                onPressed: () {},
                width: 110,
                color: const Color(0xFF192B46)),
            MapButton(
              buttonText: 'Stop Ride',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StopRide();
                  },
                );
              },
              color: Color(0xFFECB21E),
              width: 85,
            ),
          ],
        ),
      ),
      const HomeListCard(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: CustomButton(label: 'View All'),
      ),
    ]);
  }
}
