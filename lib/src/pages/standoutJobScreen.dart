import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/basicJobScreen.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class StandoutSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.listTileColor,
        title: Text(
          'Standout Job',
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
                    height: 40.0,
                  ),
                  Column(
                    children: <Widget>[
                      // Switch button
                      BasicJobSubscription.switchBDTtoDollar(),
                      SizedBox(
                        height: 20.0,
                      ),
                      boldRowTitle('Standout'),
                      //Selected Job Number
                      BasicJobSubscription.editJobAmount('Jobs'),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Amount row
                      BasicJobSubscription.showAmount('Amount', '44,250'),
                      SizedBox(
                        height: 30.0,
                      ),
                      boldRowTitle('Standout Premium'),
                      BasicJobSubscription.editJobAmount('Jobs'),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Amount row
                      BasicJobSubscription.showAmount('Amount', '44,250'),
                      SizedBox(
                        height: 30.0,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      BasicJobSubscription.showAmount('Sub Total', '2,212.5'),
                      SizedBox(
                        height: 30.0,
                      ),
                      BasicJobSubscription.showAmount('VAT (5%)', '2,212.5'),
                    ],
                  ),
                ],
              ),
            ),
            BasicJobSubscription.totalAmountBottom('46,462.5'),
          ]),
    );
  }

  static Widget boldRowTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text('$title',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
