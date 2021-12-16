import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_car/fresh_car_home_screen.dart';
import 'package:fresh_car/widgets/my_drawer.dart';

void main() {
  runApp(FreshCar());
}

class FreshCar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MyDrawer(),
        body: FreshCarHomeScreen(),
      ),
    );
  }
}
