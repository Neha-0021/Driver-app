import 'package:driver_app/Organism/Profile-drawer.dart';
import 'package:driver_app/atom/home/home-header.dart';
import 'package:driver_app/Molecules/mapper.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/state-management/profile-state.dart';

import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
     final myProvider = Provider.of<ProfileState>(context, listen: false);
      myProvider.getDriver();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AlertBundle alert = AlertBundle();

  toggleDrawer() {
    if (mounted) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeState>(
      builder: (context, homeState, child) => Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [ProfileDrawer()],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              HomeHeader(
                openSideDrawer: () => toggleDrawer(),
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
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children:  [Mapper()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
