import 'package:driver_app/atom/custom-radioButton.dart';
import 'package:flutter/material.dart';

class CompleteRide extends StatelessWidget {
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
                  fontFamily: 'Publica Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
            child:  Text(
              'Are you sure you want to mark this ride  completed? you will not will able to  change it again ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF75879B),
                fontSize: 12,
                fontFamily: 'Publica Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
            ),
           
           
             Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 22),
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: 130,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Color(0xFF192B46),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Yes, I’m Sure',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}