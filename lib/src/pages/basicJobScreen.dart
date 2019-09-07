import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/basicJobBloc.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';

class BasicJobSubscription extends StatefulWidget {
  @override
  _BasicJobSubscriptionState createState() => _BasicJobSubscriptionState();
}

class _BasicJobSubscriptionState extends State<BasicJobSubscription> {
  BasicJobBloc basicJobBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basic Job',
        ),
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
/*                      // Switch button
                      Commons.switchBDTtoDollar(),
                      SizedBox(
                        height: 20.0,
                      ),*/
                      //Selected Job Number
                      Commons.editJobAmount(
                          'Jobs',
                          basicJobBloc.basicJobNum,
                          basicJobBloc.sinkBasicJobNumber,
                          basicJobBloc.incrementJobNum,
                          basicJobBloc.decrementJobNum,
                          '0'),
                      SizedBox(
                        height: 30.0,
                      ),
                      //Amount row
                      StreamBuilder(
                          stream: basicJobBloc.basicJobFee,
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
                          stream: basicJobBloc.jobVat,
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
                stream: basicJobBloc.totalAmount,
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
    basicJobBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    basicJobBloc = BlocProvider.of(context);
    basicJobBloc.sinkBasicJobNumber('0', 0);
  }
}
