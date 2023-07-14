import 'package:driver_app/atom/Driver/HeaderWith-BackButton.dart';
import 'package:flutter/material.dart';

class DriverRating extends StatelessWidget {
  const DriverRating({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
               HeaderwithBackButton(
                Titletext: 'Driver Rating',
                subtitletext: 'Check what your customers says about you!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
