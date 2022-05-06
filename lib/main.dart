import 'package:assignment_crops_app/screens/tabs.dart';
import './screens/screen2.dart';
import './screens/screen1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainWidgetTree());
}

class MainWidgetTree extends StatefulWidget {
  const MainWidgetTree({Key? key}) : super(key: key);

  @override
  State<MainWidgetTree> createState() => _MainWidgetTreeState();
}

class _MainWidgetTreeState extends State<MainWidgetTree> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 226, 226, 226),
        primaryColor: Color.fromARGB(255, 226, 226, 226),
        accentColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          subtitle1: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.bold),
          headline1: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      routes: {
        CropsData.routeName: (ctx) => CropsData(),
        GoogleMaps.routeName: (ctx) => GoogleMaps(),
      },
      home: TabsScreen(),
    );
  }
}
