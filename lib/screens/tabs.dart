import 'package:assignment_crops_app/custom_icons_icons.dart';
import 'package:assignment_crops_app/screens/screen1.dart';
import 'package:assignment_crops_app/screens/screen2.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static int selectedPageIndex = 0;
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pages = [
    {'page': CropsData(), 'title': 'Dashboard'},
    {'page': GoogleMaps(), 'title': 'Tracking'},
    {'page': GoogleMaps(), 'title': 'Profile'},
  ];

  void SelectPage(int index) {
    setState(
      () => TabsScreen.selectedPageIndex = index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _pages[TabsScreen.selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        selectedIconTheme: IconThemeData(size: 40),
        selectedFontSize: 15,
        unselectedItemColor: Colors.grey.shade500,
        selectedItemColor: Colors.grey.shade500,
        currentIndex: TabsScreen.selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        onTap: SelectPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.dashboard,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(CustomIcons.heart),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(CustomIcons.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
