import 'package:flutter/material.dart';

import '../Button.dart';

class NoteAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 320,
        height: 200,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.only(top: 29)),
            const Text(
              'Please Note!',
              style: textHeadingstyle,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'You can’t change your personal details here. Only the admin can make those edits. Please contact the admin directly to update your details. They will help you with the necessary changes.',
                style: textSubHeadingStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: CustomButton(
                    label: 'Okay!',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const TextStyle textHeadingstyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 20,
  fontWeight: FontWeight.w500,
  height: 1.2,
  letterSpacing: 0.0,
  color: Color(0xFF000000),
  decoration: TextDecoration.none,
);

const TextStyle textSubHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 12,
  fontWeight: FontWeight.w300,
  height: 1.25,
  letterSpacing: 0.0,
  color: Color(0xFF75879B),
  decoration: TextDecoration.none,
);
