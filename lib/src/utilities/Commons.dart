import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class Commons {
  static Widget editJobAmount(String title, Stream stream, Function changeFunction,Function inc,Function dec) {
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
                }), //                                :
            Container(
              height: 40.0,
              width: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Constants.listTileColor),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.data.toString() != _controller.text &&
                        snapshot.data.toString() != null &&
                        snapshot.data is String) {
                      _controller.text = snapshot.data.toString();
                      _controller.selection = TextSelection.collapsed(
                          offset: _controller.text.length);
                    }
                    return TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      decoration:
                      InputDecoration.collapsed(hintText: ''),
                      cursorColor: Constants.listTileColor,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        changeFunction(value);
                        _controller.selection = TextSelection.collapsed(
                            offset: value.length);
                      },
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


}