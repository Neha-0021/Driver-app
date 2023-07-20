import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final void Function() openSideDrawer;

  const HomeHeader({super.key, required this.openSideDrawer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF192B46)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello Ramesh',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Start a journey!',
                    style: TextStyle(
                      color: Color(0xFF75879B),
                      fontSize: 14,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: openSideDrawer,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/view.png',
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
