import 'package:driver_app/atom/constant/common.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  final void Function()? openSideDrawer;

  const HomeHeader({Key? key, required this.openSideDrawer}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeHeaderComponent();
  }
}

class HomeHeaderComponent extends State<HomeHeader>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final stateCall = Provider.of<HomeState>(context, listen: false);
    stateCall.getUserProfile();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeState>(
      builder: (context, homeState, child) => Column(
        children: [
          Container(
            height: 160,
            decoration: const BoxDecoration(color: Color(0xFF192B46)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Ramesh',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'PublicaSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Start a journey!',
                          style: TextStyle(
                            color: Color(0xFF75879B),
                            fontSize: 14,
                            fontFamily: 'Publica Sans',
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
                              homeState.saveUserdetails["profile_photo"] ??
                                  CommonConstant.profileImage,
                              width: 42,
                              height: 42,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xFF192B46),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFFECB21E),
              labelColor: const Color(0xFFECB21E),
              unselectedLabelColor: const Color(0xFF75879B),
              tabs: const [
                Tab(
                  child: Text(
                    'Map',
                    style: TextStyle(
                      fontFamily: 'PublicaSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'List',
                    style: TextStyle(
                      fontFamily: 'PublicaSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
