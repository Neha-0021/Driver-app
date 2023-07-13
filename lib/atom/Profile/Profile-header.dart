import 'package:driver_app/atom/constant/common.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatefulWidget {
  final void Function()? openSideDrawer;

  const ProfileHeader({super.key, required this.openSideDrawer});

  @override
  State<StatefulWidget> createState() {
    return ProfileHeaderComponent();
  }
}

class ProfileHeaderComponent extends State<ProfileHeader> {
  @override
  void initState() {
    super.initState();
    final stateCall = Provider.of<HomeState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return (Consumer<HomeState>(
        builder: (context, homeState, child) => Padding(
            padding: const EdgeInsets.all(26),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello ${homeState.saveUserdetails["firstname"]} ,",
                          style: textHeadingstyle,
                        ),
                        Text(
                            "Driver id : ${homeState.saveUserdetails["_id"]!.toString().isNotEmpty ? homeState.saveUserdetails["_id"]?.toString().substring(0, 3) : ""}",
                            style: textSubHeadingStyle)
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
                              child: Image.network(
                                homeState.saveUserdetails["profile_photo"] ??
                                    CommonConstant.profileImage,
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                              ),
                            ))
                      ],
                    ))
              ],
            ))));
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
