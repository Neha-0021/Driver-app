import 'package:flutter/material.dart';
import 'package:driver_app/model/rating-model.dart';

class DriverListCard extends StatelessWidget {
  final Driver driver;
  final User user;

  const DriverListCard({Key? key, required this.driver, required this.user})
      : super(key: key);

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
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 31,
              width: 31,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.profilePhoto ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.firstname} ${user.lastname}',
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
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(children: [
                const Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.green,
                ),
                Text(
                  '${driver.rating ?? 0}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'PublicaSans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ])),
        ]),
      ),
    );
  }
}
