import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/basicJobScreen.dart';
import 'package:service_package_calculator/src/pages/standoutJobScreen.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/Commons.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class HotJobSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.listTileColor,
        title: Text(
          'Hot Job',
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              routes.goToHomePage(context);
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 30.0, right: 10.0),
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: <Widget>[
                    // Switch button
                    BasicJobSubscription.switchBDTtoDollar(),
                    SizedBox(
                      height: 20.0,
                    ),
                    StandoutSubscription.boldRowTitle('Hot Job'),
                    //Selected Job Number
//                    BasicJobSubscription.editJobAmount('Jobs', context),
                    SizedBox(
                      height: 20.0,
                    ),
                    //Amount row
                    Commons.showAmount('Amount', '44,250'),
                    showDiscount('45'),
                    SizedBox(
                      height: 30.0,
                    ),
                    StandoutSubscription.boldRowTitle('Hot Job Premium'),
//                    BasicJobSubscription.editJobAmount('Jobs', context),
                    SizedBox(
                      height: 20.0,
                    ),
                    //Amount row
                    Commons.showAmount('Amount', '44,250'),
                    showDiscount('45'),
                    SizedBox(
                      height: 30.0,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Commons.showAmount('Sub Total', '2,212.5'),
                    SizedBox(
                      height: 30.0,
                    ),
                    Commons.showAmount('VAT (5%)', '2,212.5'),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BasicJobSubscription.totalAmountBottom('46,462.5'),
        ],
      ),
    );
  }

  static Widget showDiscount(String discountAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 5.0, right: 15.0),
            child: Text('$discountAmount% discount appplied',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic))),
      ],
    );
  }
}
