import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';
import 'package:driver_app/atom/button.dart';
import 'package:driver_app/atom/home/HomeListCard.dart';
import 'package:driver_app/atom/home/MapButton.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  String htmlContent() {
    return '''
    <!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Display a map with a custom style</title>
    <meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="https://unpkg.com/mapbox-gl@2.4.1/dist/mapbox-gl.css" rel="stylesheet" />
    <style>
      body { margin: 0; padding: 0; }
      #map { position: absolute; top: 0; bottom: 0; width: 100%; }
    </style>
  </head>
  <body>
    <div id="map"></div>
    <script src="https://maps.flightmap.io/flightmapjs"></script>
    <script>
      var map = new flightmap.Map({
        container: 'map', // container id
        style: 'style-dark.json', // hosted style id
        center: [-77.38, 39], // starting position
        zoom: 3, // starting zoom
        accessToken: '88108930-b699-11ed-8a6d-8f496b2a9392'
      });
    </script>
  </body>
</html>

''';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 300,
          child: WebView(
            initialUrl: Uri.dataFromString(htmlContent(), mimeType: 'text/html')
                .toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebResourceError: (WebResourceError error) {},
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
                color: const Color(0xFF192B46),
              ),
              MapButton(
                buttonText: 'Complete Ride',
                onPressed: () {},
                width: 110,
                color: const Color(0xFF192B46),
              ),
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
      ],
    );
  }
}
