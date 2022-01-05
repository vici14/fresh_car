import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_car/fresh_car_home_screen.dart';
import 'package:fresh_car/widgets/my_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(FreshCar());
}

class FreshCar extends StatefulWidget {
  @override
  _FreshCarState createState() => _FreshCarState();
}

class _FreshCarState extends State<FreshCar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      drawer: MyDrawer(),
      body: FreshCarHomeScreen(),
    ));
  }
}
