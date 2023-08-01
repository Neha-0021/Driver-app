import 'package:driver_app/Pages/Next-stop.dart';
import 'package:driver_app/atom/Pop-Up/Stop-ride.dart';
import 'package:driver_app/atom/button.dart';
import 'package:driver_app/atom/home/HomeListCard.dart';
import 'package:driver_app/atom/home/MapButton.dart';
import 'package:driver_app/atom/mapper.dart';
import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  bool isMapExpanded = false;

  void toggleMapSize() {
    setState(() {
      isMapExpanded = !isMapExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isMapExpanded ? MediaQuery.of(context).size.height : 300,
              child: Mapper(),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: toggleMapSize,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isMapExpanded ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: !isMapExpanded,
          child: Padding(
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
                  buttonText: 'Start Ride',
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
        ),
        Visibility(
          visible: !isMapExpanded,
          child: const HomeListCard(),
        ),
        Visibility(
          visible: !isMapExpanded,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: CustomButton(
              label: 'View All',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NextStop()),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
