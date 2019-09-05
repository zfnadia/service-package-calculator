import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/basicAndCVBankBloc.dart';
import 'package:service_package_calculator/src/bloc/basicJobBloc.dart';
import 'package:service_package_calculator/src/bloc/customizedJobBloc.dart';
import 'package:service_package_calculator/src/bloc/hotJobBloc.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/bloc/standoutAndCVBankBloc.dart';
import 'package:service_package_calculator/src/bloc/standoutJobBloc.dart';
import 'package:service_package_calculator/src/pages/homeScreen.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: BasicJobBloc(),
        child: BlocProvider(
            bloc: StandoutJobBloc(),
            child: BlocProvider(
              bloc: HotJobBloc(),
              child: BlocProvider(
                  bloc: BasicAndCVBankBloc(),
                  child: BlocProvider(
                      bloc: StandoutAndCVBankBloc(),
                      child: BlocProvider(
                          bloc: CustomizedJobBloc(),
                          child: MaterialApp(
                              home: HomeScreen(),
                            theme: ThemeData(primaryColor: Constants.primaryColor),
                          )
                      )
                  )
              ),
            )
        )
    );
  }
}
