import 'package:flutter/material.dart';

class CompleteRide extends StatelessWidget {
  const CompleteRide({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 320,
        height: 185,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Complete Ride?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'PublicaSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Are you sure you want to mark this ride  completed? you will not will able to  change it again ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF75879B),
                  fontSize: 12,
                  fontFamily: 'PublicaSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(130, 41),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Go Back',
                        style: TextStyle(
                          fontFamily: 'PublicaSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF192B46),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(130, 41),
                        backgroundColor: const Color(0xFF192B46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'Yes, I’m Sure',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14,
                          fontFamily: 'PublicaSans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
