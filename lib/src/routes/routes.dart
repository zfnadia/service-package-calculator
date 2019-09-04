import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/homeScreen.dart';

class Routes {
  void goToSelectedPage(BuildContext context, presentScreen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => presentScreen));
  }
 }

final routes = Routes();