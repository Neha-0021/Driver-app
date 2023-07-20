import 'package:driver_app/Pages/History-page.dart';
import 'package:driver_app/Pages/Notification-page.dart';
import 'package:driver_app/atom/Custom-Navigation.dart';
import 'package:flutter/material.dart';

import '../Pages/home/HomePage.dart';



class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return BottomBarTab();
  }
}

class BottomBarTab extends State<BottomBar> {
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage = const HomePage();

  void changeScreen(selectedScreen) {
    switch (selectedScreen) {
      case 'HOME':
        setState(() {
          currentPage = const HomePage();
        });
        break;
     
       
      case 'HISTORY':
        setState(() {
          currentPage = HistoryPage();
        });
        break;
      case 'NOTIFICATION':
        setState(() {
          currentPage = NotificationPage();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageStorage(bucket: bucket, child: currentPage),
      bottomNavigationBar: CustomNavigationBar(
        changeScreen: (String e) => changeScreen(e),
      ),
    ));
  }
}
