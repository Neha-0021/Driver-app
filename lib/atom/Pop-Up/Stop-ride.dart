import 'package:driver_app/atom/custom-radioButton.dart';
import 'package:flutter/material.dart';

class StopRide extends StatelessWidget {
  const StopRide({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 320,
        height: 200,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Container(
          color: Color.fromRGBO(73, 86, 100, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/Star.png',
                      width: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Please tell us the reason:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Publica Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomRadioButton(
                  text: 'Vehicle Breakdown',
                  isSelected: true,
                  onClick: () {
                    // Handle radio button click logic here
                  },
                ),
                CustomRadioButton(
                  text: 'All users dropped',
                  isSelected: false,
                  onClick: () {
                    // Handle radio button click logic here
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 160,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Go Back',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 160,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Color(0xFF192B46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(3)),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


