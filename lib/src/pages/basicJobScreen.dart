import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class BasicJobSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final int basicJobRate = Constants.sourceData[0]['job_listing'][0]['basic'][0]['rate'];
//    print('KKKKKKKKKKKKKK $basicJobRate');
    // TODO: implement build
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Constants.listTileColor,
        title: Text(
          'Basic Job',
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
                      switchBDTtoDollar(),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Selected Job Number
                      editJobAmount('Jobs'),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Amount row
                      showAmount('Amount', '44,250'),
                      SizedBox(
                        height: 40.0,
                      ),
                      showAmount('VAT (5%)', '2,212.5'),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            totalAmountBottom('46,462.5'),
          ]),
    );
  }

  static Widget switchBDTtoDollar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100.0,
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
              border: Border.all(color: Constants.listTileColor),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            children: <Widget>[
              Text('BDT'), //value == false ? 'BDT' : 'USD'
              Switch(value: false, onChanged: null)
            ],
          ),
        )
      ],
    );
  }

  static Widget editJobAmount(String title) {
    return Row(
      children: <Widget>[
        Text('$title', style: TextStyle(fontSize: 20.0, color: Colors.black87)),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
//                            _itemCount!=0? new
            IconButton(
                icon: Icon(Icons.remove_circle_outline), onPressed: () {}),
//                                :
            Container(
              height: 40.0,
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Constants.listTileColor),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration.collapsed(hintText: ''),
                cursorColor: Constants.listTileColor,
                keyboardType: TextInputType.number,
                onTap: () {},
              ),
            ),
//                            Text(_itemCount.toString()),
            IconButton(
                icon: new Icon(Icons.add_circle_outline), onPressed: () {}),
          ],
        ),
      ],
    );
  }

  static Widget showAmount(String title, String amount) {
    return Row(
      children: <Widget>[
        Text('$title', style: TextStyle(fontSize: 20.0, color: Colors.black87)),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 15.0),
                child: Text('$amount  BDT',
                    style: TextStyle(fontSize: 20.0, color: Colors.black87))),
          ],
        )
      ],
    );
  }

  static Widget totalAmountBottom(String amount) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black87,
        ),
      ),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80.0,
            width: double.infinity,
            color: Constants.listTileColor,
            child: Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Amount to pay:   $amount BDT',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )),
    );
  }
}
