import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class Commons {
  static Widget switchBDTtoDollar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100.0,
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
              border: Border.all(color: Constants.primaryColor),
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

  static Widget editJobAmount(String title, Stream stream,
      Function changeFunction, Function inc, Function dec, String init) {
    final _controller = TextEditingController();
    return Row(
      children: <Widget>[
        Text('$title', style: TextStyle(fontSize: 20.0, color: Colors.black87)),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () {
                  dec();
                }),
            Container(
              height: 40.0,
              width: 100.0,
              decoration: BoxDecoration(
                  border: Border.all(color: Constants.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: StreamBuilder(
                  stream: stream,
                  initialData: init,
                  builder: (context, snapshot) {
                    if (snapshot.data.toString() != _controller.text &&
                        snapshot.data.toString() != null &&
                        snapshot.data is String) {
                      _controller.text = snapshot.data.toString();
                      _controller.selection = TextSelection.collapsed(
                          offset: _controller.text.length);
                    }
                    return Center(
                      child: TextField(
                        controller: _controller,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration.collapsed(hintText: ''),
                        cursorColor: Constants.primaryColor,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          changeFunction(value);
                          _controller.selection =
                              TextSelection.collapsed(offset: value.length);
                        },
                      ),
                    );
                  }),
            ),
            IconButton(
                icon: new Icon(Icons.add_circle_outline),
                onPressed: () {
                  inc();
                }),
          ],
        )
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
            color: Constants.primaryColor,
            child: Container(
              margin: EdgeInsets.only(right: 20.0, top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Amount to pay:    ',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('$amount BDT',
                              style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
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

  static Widget showDiscount(String discountAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 5.0, right: 15.0),
            child: Text('$discountAmount discount appplied',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic))),
      ],
    );
  }

  static Widget cvCount(String cvNum, String cvPrice, bool cvStatus, Function changeFunc) {
    bool isChecked = cvStatus;
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Checkbox(
//                checkColor: Colors.green,
//                activeColor: Colors.blue,
                value: isChecked,
                onChanged: (value) {
                  isChecked = value;
                  changeFunc(isChecked);
                },
              ),
              Text('CVs: $cvNum',
                  style: TextStyle(fontSize: 20.0, color: Colors.black87))
            ],
          ),
          Spacer(),
          Text('$cvPrice  BDT',
              style: TextStyle(fontSize: 20.0, color: Colors.black87))
        ],
      ),
    );
  }

//snapshot, getSelectedMonth, sinkSelectedMonth
  static Widget validitySelection(
      snapshot, Stream stream, Function changeFunc) {
    if (snapshot.hasData && snapshot.data != null) {
      List<int> validMonthList = snapshot.data.toList();
      print('KKKKKKKKK $validMonthList');
      return Row(
        children: <Widget>[
          Text('Validity (Month)',
              style: TextStyle(fontSize: 20.0, color: Colors.black87)),
          Spacer(),
          Row(
            children: <Widget>[
              Container(
                width: 130.0,
                height: 80,
                margin: EdgeInsets.only(right: 6.0),
                padding: EdgeInsets.all(2.0),
                child: StreamBuilder(
                    stream: stream,
                    initialData: '6',
                    builder: (context, snapshot) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              snapshot.data == null ? 0 : validMonthList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              margin: EdgeInsets.only(left: 3.0, right: 3.0),
                              child: RaisedButton(
                                child: Text(
                                  '${validMonthList[index]}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: snapshot.data is String &&
                                              snapshot.data ==
                                                  validMonthList[index]
                                                      .toString()
                                          ? Colors.white
                                          : Colors.black54),
                                ),
                                splashColor: Colors.grey,
                                shape: CircleBorder(),
                                color: snapshot.data is String &&
                                        snapshot.data ==
                                            validMonthList[index].toString()
                                    ? Colors.green
                                    : Colors.white70,
                                onPressed: () {
                                  if (snapshot.data is String &&
                                      snapshot.data == validMonthList[index]) {
                                    changeFunc('');
                                  } else {
                                    changeFunc(
                                        validMonthList[index].toString());
                                  }
                                },
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ],
      );
    } else {
      return Text('');
    }
  }
}
