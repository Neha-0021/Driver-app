import 'package:flutter/widgets.dart';

class NoRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/rating.png",
          width: 100,
          height: 100,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "No Ratings Yet!",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Currently, there are no ratings available. Once customers start providing their ratings, they will be displayed here. Stay tuned for feedback from your valued customers, as their ratings will soon be showcased in this section.",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
