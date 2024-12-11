import 'package:flutter/widgets.dart';

class ProfileHeader extends StatefulWidget {
  final void Function()? openSideDrawer;

  const ProfileHeader({required this.openSideDrawer});

  @override
  State<StatefulWidget> createState() {
    return ProfileHeaderComponent();
  }
}

class ProfileHeaderComponent extends State<ProfileHeader> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(26),
        child: Row(
          children: [
            const Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Ramesh,",
                      style: textHeadingstyle,
                    ),
                    Text(" Driver ID: 25", style: textSubHeadingStyle)
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: widget.openSideDrawer,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/view.png',
                            width: 42,
                            height: 42,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ],
                ))
          ],
        ));
  }
}

const TextStyle textHeadingstyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 24,
  fontWeight: FontWeight.w700,
  height: 1.2,
  letterSpacing: 0.0,
  color: Color(0xFF000000),
);

const TextStyle textSubHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.25,
  letterSpacing: 0.0,
  color: Color(0xFF75879B),
);
