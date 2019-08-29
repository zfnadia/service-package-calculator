import 'package:flutter/material.dart';
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
      body: Column(children: <Widget>[
        Container(
          height: 300.0,
          child: ListView(
            padding: EdgeInsets.only(left: 30.0, right: 10.0),
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Column(
                children: <Widget>[
                  // Switch button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        margin: EdgeInsets.only(right: 15.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Constants.listTileColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0))),
                        child: Row(
                          children: <Widget>[
                            Text('BDT'), //value == false ? 'BDT' : 'USD'
                            Switch(value: false, onChanged: null)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text('Standout', style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  //Selected Job Number
                  Row(
                    children: <Widget>[
                      Text('Jobs',
                          style:
                          TextStyle(fontSize: 20.0, color: Colors.black87)),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
//                            _itemCount!=0? new
                          IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {}),
//                                :
                          Container(
                            height: 40.0,
                            width: 100.0,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Constants.listTileColor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration:
                              InputDecoration.collapsed(hintText: ''),
                              cursorColor: Constants.listTileColor,
                              keyboardType: TextInputType.number,
                              onTap: () {},
                            ),
                          ),
//                            Text(_itemCount.toString()),
                          IconButton(
                              icon: new Icon(Icons.add_circle_outline),
                              onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Amount row
                  Row(
                    children: <Widget>[
                      Text('Amount',
                          style:
                          TextStyle(fontSize: 20.0, color: Colors.black87)),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 15.0),
                              child: Text('44,250   BDT',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black87))),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text('VAT (5%)',
                          style:
                          TextStyle(fontSize: 20.0, color: Colors.black87)),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 15.0),
                              child: Text('2,212.5   BDT',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black87))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
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
                        Text('Amount to pay:     46,462.5   BDT',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}
