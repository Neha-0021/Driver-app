import 'package:flutter/widgets.dart';

class NoNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/notification.png",
          width: 100,
          height: 100,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "No new notifications",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "There are no notifications right now! Once you begin using our app, all notifications will appear here!",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
