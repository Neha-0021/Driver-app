import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'By Signing Up to account, you agree to our  ',
            style: TextStyle(
              fontFamily: 'PublicaSans',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: 0.0,
              color: Color(0xFF939EAA),
            ),
          ),
          TextSpan(
            text: 'Terms and Conditions',
            style: TextStyle(
              fontFamily: 'PublicaSans',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: 0.0,
              color: Color(0xFF192B46),
            ),
          ),
          TextSpan(
            text: ' and ',
            style: TextStyle(
              fontFamily: 'PublicaSans',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: 0.0,
              color: Color(0xFF939EAA),
            ),
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              fontFamily: 'PublicaSans',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.25,
              letterSpacing: 0.0,
              color: Color(0xFF192B46),
            ),
          ),
        ],
      ),
    ));
  }
}
