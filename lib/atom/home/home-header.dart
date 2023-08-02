import 'package:driver_app/atom/constant/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state-management/home-state.dart';

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
    final stateCall = Provider.of<HomeState>(context, listen: false);
    stateCall.getDriverProfile();
  }

  @override
  Widget build(BuildContext context) {
    return (Consumer<HomeState>(
        builder: (context, homeState, child) => Container(
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
                            "Hello ${homeState.saveDriverDetails["firstname"]} ,",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'PublicaSans',
                              fontWeight: FontWeight.w700,
                            ),
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
                      GestureDetector(
                            onTap: widget.openSideDrawer,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                homeState.saveDriverDetails["profile_photo"] ??CommonConstant.profileImage,
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                              ),
                            ))
                  ],
                ),
              ),
            )));
  }
}
