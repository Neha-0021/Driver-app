import 'package:flutter/material.dart';

class DriverListCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const DriverListCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFD2DBD6),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/Driverimage.png',
                height: 31,
                width: 31,
              ),
            ),
            const Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rahul Chorasiya', // Sample driver name (should be fetched from 'data')
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Ahmedabad - Kanpur • Sun 14 May', // Sample travel details (should be fetched from 'data')
                    style: TextStyle(
                      color: Color(0xFF75879B),
                      fontSize: 10,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.green,
                  ),
                  Text(
                    '4.0', // Sample average rating (should be fetched from 'data')
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'PublicaSans',
                      fontWeight: FontWeight.w500,
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
