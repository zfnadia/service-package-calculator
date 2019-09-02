import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/mainBloc.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class BasicJobSubscription extends StatefulWidget {
  @override
  _BasicJobSubscriptionState createState() => _BasicJobSubscriptionState();
}

class _BasicJobSubscriptionState extends State<BasicJobSubscription> {
  MainBloc mainBloc;

  @override
  Widget build(BuildContext context) {
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
                      Commons.switchBDTtoDollar(),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Selected Job Number
                      Commons.editJobAmount(
                          'Jobs',
                          mainBloc.basicJobNum,
                          mainBloc.sinkBasicJobNumber,
                          mainBloc.incrementJobNum,
                          mainBloc.decrementJobNum),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Amount row
                      StreamBuilder(
                          stream: mainBloc.basicJobFee,
                          builder: (context, snapshot) {
                            return Commons.showAmount(
                                'Amount',
                                snapshot.hasData && snapshot.data != null
                                    ? '${snapshot.data}'
                                    : '0.0');
                          }),
                      SizedBox(
                        height: 40.0,
                      ),
                      StreamBuilder(
                          stream: mainBloc.jobVat,
                          builder: (context, snapshot) {
                            return Commons.showAmount(
                                'VAT (5%)',
                                snapshot.hasData && snapshot.data != null
                                    ? '${snapshot.data}'
                                    : '0.0');
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: mainBloc.totalAmount,
                builder: (context, snapshot) {
                  return Commons.totalAmountBottom(
                      snapshot.hasData && snapshot.data != null
                          ? '${snapshot.data}'
                          : '0.0');
                }),
          ]),
    );
  }

  @override
  void dispose() {
    mainBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc = BlocProvider.of(context);
  }
}
