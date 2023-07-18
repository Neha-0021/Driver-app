import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  Function(String) changeScreen;

  CustomNavigationBar({super.key, required this.changeScreen});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  IconData selectedIcon = Icons.home;

  Color getColor(status) {
    if (status) {
      return const Color(0xFF192B46);
    } else {
      return const Color(0xFF75879B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIcon = Icons.home;
                });
                widget.changeScreen("HOME");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home, color: getColor(selectedIcon == Icons.home)),
                  Text(
                    'Home',
                    style: TextStyle(
                        fontFamily: 'PublicaSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: 18 / 18,
                        color: getColor(selectedIcon == Icons.home)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIcon = Icons.history;
                });
                widget.changeScreen("HISTORY");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history,
                      color: getColor(selectedIcon == Icons.history)),
                  Text(
                    'History',
                    style: TextStyle(
                        fontFamily: 'PublicaSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: 18 / 18,
                        color: getColor(selectedIcon == Icons.history)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIcon = Icons.notifications;
                  });
                  widget.changeScreen("NOTIFICATION");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications,
                        color: getColor(selectedIcon == Icons.notifications)),
                    Text(
                      'Notifications',
                      style: TextStyle(
                          fontFamily: 'PublicaSans',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          height: 18 / 18,
                          color: getColor(selectedIcon == Icons.notifications)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
