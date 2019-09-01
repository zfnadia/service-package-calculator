import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/basicAndCVBankScreen.dart';
import 'package:service_package_calculator/src/pages/basicJobScreen.dart';
import 'package:service_package_calculator/src/pages/hotJobScreen.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/Commons.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class StandoutAndCVBankSub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.listTileColor,
        title: Text(
          'Bulk Subscription: \nStandout Job and CV Bank',
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
                      BasicJobSubscription.switchBDTtoDollar(),
                      SizedBox(
                        height: 20.0,
                      ),
//                      BasicJobSubscription.editJobAmount('Standout Jobs', context),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Amount row
                      Commons.showAmount('Amount', '44,250'),
                      HotJobSubscription.showDiscount('30'),
                      SizedBox(
                        height: 30.0,
                      ),
                      BasicAndCVBankSub.cvCount(),
                      SizedBox(
                        height: 20.0,
                      ),
                      BasicAndCVBankSub.validitySelection(),
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
                  )
                ],
              )),
          BasicJobSubscription.totalAmountBottom('46,462.5'),
        ],
      ),
    );
  }
}
