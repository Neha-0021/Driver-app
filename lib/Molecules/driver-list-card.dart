import 'package:flutter/material.dart';
import 'package:driver_app/Modal/RatingModal.dart'; // Make sure to import the correct path for RatingModel

class DriverListCard extends StatelessWidget {
  final RatingModels data;
  const DriverListCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Driver driver = data.driver[0]; // Accessing the driver property from RatingModel
    final User user = data.user[0]; // Accessing the user property from RatingModel

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
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Image.network(
              user.profilePhoto, // Using the profile photo URL from user data
              height: 31,
              width: 31,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.firstname} ${user.lastname}', // Displaying user's full name
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'PublicaSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '${user.workplace} - ${user.address} • ${user.officeTimeFrom}',
                  style: const TextStyle(
                    color: Color(0xFF75879B),
                    fontSize: 10,
                    fontFamily: 'PublicaSans',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.green,
                    ),
                    Text(
                      '${driver.rating}', // Displaying driver's rating
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'PublicaSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
