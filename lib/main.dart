import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/mainBloc.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/pages/homeScreen.dart';
import 'package:service_package_calculator/src/repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    repository.loadDataFromAsset();
    return BlocProvider(
        bloc: MainBloc(), child: MaterialApp(home: HomeScreen()));
  }
}
