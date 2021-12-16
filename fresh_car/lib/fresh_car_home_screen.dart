import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_car/features/home/home_screen.dart';
import 'package:fresh_car/features/store/store_screen.dart';
import 'package:fresh_car/widgets/my_drawer.dart';

class FreshCarHomeScreen extends StatefulWidget {
  @override
  State<FreshCarHomeScreen> createState() {
    return _FreshCarHomeScreenState();
  }
}

class _FreshCarHomeScreenState extends State<FreshCarHomeScreen> {
  CupertinoTabController _tabController = CupertinoTabController();
  List<Widget>? listTab;
  int oldTab = 0;

  @override
  void initState() {
    super.initState();
    listTab = [
      CupertinoTabView(
        builder: (context) => HomeScreen(),
      ),
      CupertinoTabView(
        builder: (context) => StoreScreen(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: true,
      controller: _tabController,
      tabBuilder: (BuildContext context, int index) {
        return listTab![_tabController.index];
      },
      tabBar: _buildBottomBar(),
    );
  }

  CupertinoTabBar _buildBottomBar() {
    return CupertinoTabBar(
        activeColor: Colors.green,
        onTap: onTabTap,
        backgroundColor: Colors.grey.withOpacity(0.5),
        items: <BottomNavigationBarItem>[
          _buildBottomBarItem(
            icon: Icon(Icons.home),
            label: "home",
            activeIcon: Icon(
              Icons.home,
              color: Colors.green,
            ),
          ),
          _buildBottomBarItem(
            icon: Icon(Icons.store),
            label: "Store",
            activeIcon: Icon(
              Icons.store,
              color: Colors.green,
            ),
          ),
        ]);
  }

  BottomNavigationBarItem _buildBottomBarItem(
      {required Widget icon,
      required Widget activeIcon,
      required String label}) {
    return BottomNavigationBarItem(
        icon: icon, activeIcon: activeIcon, label: label);
  }

  void onTabTap(int index) {
    oldTab = index;
    switch (index) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
