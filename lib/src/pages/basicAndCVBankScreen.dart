import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/basicJobScreen.dart';
import 'package:service_package_calculator/src/pages/hotJobScreen.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class BasicAndCVBankSub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.listTileColor,
        title: Text(
          'Bulk Subscription: \nBasic Job and CV Bank',
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
                  BasicJobSubscription.switchBDTtoDollar(),
                  SizedBox(
                    height: 20.0,
                  ),
                  BasicJobSubscription.editJobAmount('Basic Jobs'),
                  SizedBox(
                    height: 30.0,
                  ),
                  //Amount row
                  BasicJobSubscription.showAmount('Amount', '44,250'),
                  HotJobSubscription.showDiscount('30'),
                  SizedBox(
                    height: 30.0,
                  ),
                  cvCount(),
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
  static Widget cvCount() {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.check_circle_outline)
              ),
              Text('CVs: 1000',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.black87))
            ],
          ),
          Spacer(),
          Text('4500  BDT',
              style: TextStyle(
                  fontSize: 20.0, color: Colors.black87))
        ],
      ),
    );
  }
}
