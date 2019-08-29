import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/homeScreen.dart';

class Routes {
  void goToSelectedPage(BuildContext context, presentScreen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => presentScreen));
  }

  void goToHomePage (BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
 }

final routes = Routes();