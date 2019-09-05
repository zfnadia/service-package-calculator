import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/basicAndCVBankScreen.dart';
import 'package:service_package_calculator/src/pages/basicJobScreen.dart';
import 'package:service_package_calculator/src/pages/customizedSubScreen.dart';
import 'package:service_package_calculator/src/pages/hotJobScreen.dart';
import 'package:service_package_calculator/src/pages/standoutAndCVBankScreen.dart';
import 'package:service_package_calculator/src/pages/standoutJobScreen.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List<String> pageNames = [
    '',
    'Basic Job',
    'Standout Job',
    'Hot Job',
    'Bulk Subscription: Basic Job and CV Bank',
    'Bulk Subscription: Standout Job and CV Bank',
    'Bulk Subscription: Customized',
  ];

  List<Widget> pageList = [
    BasicJobSubscription(),
    StandoutSubscription(),
    HotJobSubscription(),
    BasicAndCVBankSub(),
    StandoutAndCVBankSub(),
    CustomizedSubscription(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: pageNames.length,
          itemBuilder: (context, int index) {
            print('$index');
            return index == 0
                ? headerItem()
                : Ink(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 3,
                          bottom: index == pageNames.length - 1 ? 64.0 : 3.0),
                      child: Card(
                        color: Constants.primaryColor,
                        elevation: 3.0,
                        child: ListTile(
                          title: Text(
                            '${pageNames[index]}',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black87),
                          ),
                          onTap: () {
                            routes.goToSelectedPage(
                                context, pageList[index - 1]);
                          },
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget headerItem() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 48.0,
        ),
        Container(
          height: 150.0,
          width: 150.0,
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('assets/calculator_logo.png'),
//                fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${Constants.APP_TITLE}',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
