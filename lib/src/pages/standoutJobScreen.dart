import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/bloc/standoutJobBloc.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class StandoutSubscription extends StatefulWidget {
  @override
  _StandoutSubscriptionState createState() => _StandoutSubscriptionState();
}

class _StandoutSubscriptionState extends State<StandoutSubscription> {
  StandoutJobBloc standoutJobBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.listTileColor,
        title: Text(
          'Standout Job',
          style: TextStyle(color: Colors.black87),
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
                      // Switch button
                      Commons.switchBDTtoDollar(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Commons.boldRowTitle('Standout'),
                      //Selected Job Number
                      Commons.editJobAmount(
                          'Jobs',
                          standoutJobBloc.getBasicJobNum,
                          standoutJobBloc.sinkBasicJobNumber,
                          standoutJobBloc.incrementBasicJobNum,
                          standoutJobBloc.decrementBasicJobNum,
                          '0'),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Amount row
                      StreamBuilder(
                          stream: standoutJobBloc.getBasicJobFee,
                          builder: (context, snapshot) {
                            return Commons.showAmount(
                                'Amount',
                                snapshot.hasData && snapshot.data != null
                                    ? '${snapshot.data}'
                                    : '0.0');
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                      Commons.boldRowTitle('Standout Premium'),
                      Commons.editJobAmount(
                          'Jobs',
                          standoutJobBloc.getPremiumJobNum,
                          standoutJobBloc.sinkPremiumJobNumber,
                          standoutJobBloc.incrementPremiumJobNum,
                          standoutJobBloc.decrementPremiumJobNum,
                          '0'),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Amount row
                      StreamBuilder(
                          stream: standoutJobBloc.getPremiumJobFee,
                          builder: (context, snapshot) {
                            return Commons.showAmount(
                                'Amount',
                                snapshot.hasData && snapshot.data != null
                                    ? '${snapshot.data}'
                                    : '0.0');
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      StreamBuilder(
                          stream: standoutJobBloc.getSubTotal,
                          builder: (context, snapshot) {
                            return Commons.showAmount(
                                'Sub Total',
                                snapshot.hasData && snapshot.data != null
                                    ? '${snapshot.data}'
                                    : '0.0');
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                      StreamBuilder(
                          stream: standoutJobBloc.getVat,
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
                stream: standoutJobBloc.getSubTotalPlusVat,
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
    standoutJobBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    standoutJobBloc = BlocProvider.of(context);
    standoutJobBloc.sinkBasicJobNumber('0');
    standoutJobBloc.sinkPremiumJobNumber('0');
  }
}
