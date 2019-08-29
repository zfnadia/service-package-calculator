import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/homeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: HomeScreen());
  }
}
