import 'package:driver_app/Pages/home/HomePage.dart';
import 'package:driver_app/Pages/login.dart';
import 'package:driver_app/utils/storage.dart';
import 'package:flutter/material.dart';


class LogOutSheet extends StatelessWidget {
  

  PhoneStorage storage = PhoneStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset("assets/images/view.png", width: 104, height: 104),
          ),
          const Text(
            'Do you want to exit?',
            style: textHeadingstyle,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 62),
            child: Text(
              'Are you sure you really want to log out from your RYDTHRU account?',
              style: textSubHeadingStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      storage.removeElement("token");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: const Text(
                      'LogOut',
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
                        storage.removeElement("token");
                      Navigator.pop(
                        context,
                        ); 
                    },
                    
                    style: TextButton.styleFrom(
                      minimumSize: const Size(160, 41),
                      backgroundColor: const Color(0xFF192B46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Cancel',
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
    );
  }
}



const TextStyle textHeadingstyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: Color(0xFF000000),
);

const TextStyle textSubHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Color(0xFF75879B),
);