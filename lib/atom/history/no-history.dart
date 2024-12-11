import 'package:flutter/widgets.dart';


class NoHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/history.png",
          width: 300,
          height: 300,
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Your booking history is currently empty. As soon as you book a shuttle using our app, the details will be visible on this page.",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
