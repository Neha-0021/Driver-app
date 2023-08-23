import 'package:driver_app/Organism/Profile-drawer.dart';
import 'package:driver_app/atom/constant/common.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/state-management/profile-state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  final void Function() openSideDrawer;

  const HomeHeader({super.key, required this.openSideDrawer});

  @override
  State<StatefulWidget> createState() {
    return HomeHeaderComponent();
  }
}

class HomeHeaderComponent extends State<HomeHeader> {
  @override
  void initState() {
    super.initState();
    final stateCall = Provider.of<ProfileState>(context, listen: false);
    stateCall.getDriver();
  }

  @override
  Widget build(BuildContext context) {
    return (Consumer<ProfileState>(
        builder: (context, profileState, child) => Container(
              decoration: const BoxDecoration(color: Color(0xFF192B46)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${profileState.driverData['name']} ,",
                            style: textHeadingstyle,
                          ),
                          const Text(
                            'Start a journey!',
                            style: TextStyle(
                              color: Color(0xFF75879B),
                              fontSize: 14,
                              fontFamily: 'PublicaSans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                    profileState.driverData["profile_photo"] ??
                                        CommonConstant.profileImage,
                                    width: 42,
                                    height: 42,
                                    fit: BoxFit.cover,
                                  ),
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            )));
  }
}
