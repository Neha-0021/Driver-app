import 'package:driver_app/Molecules/Profile/Log-out.dart';
import 'package:driver_app/Pages/Driver/DriverRating.dart';
import 'package:driver_app/Pages/Profile/About-us.dart';
import 'package:driver_app/Pages/Profile/personal-details-page.dart';
import 'package:driver_app/Pages/login.dart';
import 'package:driver_app/atom/Profile/Profile-list.dart';
import 'package:driver_app/state-management/profile-state.dart';
import 'package:driver_app/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDrawer extends StatelessWidget {
  PhoneStorage storage = PhoneStorage();

  ProfileDrawer({super.key});

  // ignore: non_constant_identifier_names
  void LogOut(context, homeProvider) async {
    storage.removeElement("token");
    homeProvider.reset();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileState>(
      builder: (context, profileState, child) => Column(
        children: [
          Container(
            height: 170,
            color: const Color(0xFF192B46),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    width: 61,
                    height: 61,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: profileState.driver != null &&
                                profileState.driver!['profile_photo'] !=
                                    null
                            ? NetworkImage(
                                    profileState.driver!['profile_photo'])
                                as ImageProvider<Object>
                            : const AssetImage('assets/images/view.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${profileState.driver['firstname']} ${profileState.driver['lastname']}',
                        style: textHeadingstyle,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                              'Driver ID: ${profileState.driver['_id'].toString().substring(0, 3)}',
                              style: textSubHeadingStyle)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonalDetailPage(),
                ),
              );
            },
            child: const ProfileList(
              imagePath: 'assets/images/svg/profile-line.svg',
              title: 'Personal Details',
              actionImagePath: 'assets/images/go.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            },
            child: const ProfileList(
              imagePath: 'assets/images/svg/About.svg',
              title: 'About Us',
              actionImagePath: 'assets/images/go.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DriverRating(),
                ),
              );
            },
            child: const ProfileList(
              imagePath: 'assets/images/svg/Rating-icon.svg',
              title: 'Driver Rating',
              actionImagePath: 'assets/images/go.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (context) {
                  return LogOutSheet();
                },
              );
            },
            child: const ProfileList(
              imagePath: 'assets/images/svg/Logout.svg',
              title: 'Log Out',
            ),
          ),
        ],
      ),
    );
  }
}

const TextStyle textHeadingstyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: Color(0xFFFFFFFF),
  decoration: TextDecoration.none,
);

const TextStyle textSubHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Color(0xFF75879B),
  decoration: TextDecoration.none,
);
