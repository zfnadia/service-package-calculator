import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/pages/hotJobScreen.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';
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
                height: 30.0,
              ),
              Column(
                children: <Widget>[
                  Commons.switchBDTtoDollar(),
                  SizedBox(
                    height: 20.0,
                  ),
//                  BasicJobSubscription.editJobAmount('Basic Jobs', context),
                  SizedBox(
                    height: 30.0,
                  ),
                  //Amount row
                  Commons.showAmount('Amount', '44,250'),
                  HotJobSubscription.showDiscount('30'),
                  SizedBox(
                    height: 30.0,
                  ),
                  cvCount(),
                  SizedBox(
                    height: 20.0,
                  ),
                  validitySelection(),
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
          Commons.totalAmountBottom('46,462.5'),
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
                  child: Icon(Icons.check_circle_outline)),
              Text('CVs: 1000',
                  style: TextStyle(fontSize: 20.0, color: Colors.black87))
            ],
          ),
          Spacer(),
          Text('4500  BDT',
              style: TextStyle(fontSize: 20.0, color: Colors.black87))
        ],
      ),
    );
  }

  static Widget validitySelection() {
    return Row(
      children: <Widget>[
        Text('Validity',
            style: TextStyle(fontSize: 20.0, color: Colors.black87)),
        Spacer(),
        Row(
          children: <Widget>[
            Container(
              width: 190.0,
              height: 80,
              margin: EdgeInsets.only(right: 15.0),
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Constants.listTileColor),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 55.0,
                      height: 50.0,
                      margin: EdgeInsets.only(left: 3.0, right: 3.0),
                      child: ButtonTheme(
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.grey)),
                        child: RaisedButton(
                          child: Text("6"),
                          splashColor: Colors.red,
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ],
    );
  }
}
