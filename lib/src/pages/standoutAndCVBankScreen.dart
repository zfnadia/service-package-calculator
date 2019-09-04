import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/bloc/standoutAndCVBankBloc.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class StandoutAndCVBankSub extends StatefulWidget {
  @override
  _StandoutAndCVBankSubState createState() => _StandoutAndCVBankSubState();
}

class _StandoutAndCVBankSubState extends State<StandoutAndCVBankSub> {
  StandoutAndCVBankBloc standoutAndCVBankBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.listTileColor,
        title: Text(
          'Bulk Subscription: \nStandout Job and CV Bank',
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
                  Commons.switchBDTtoDollar(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Commons.editJobAmount(
                      'Standout Jobs',
                      standoutAndCVBankBloc.getStandoutJobNum,
                      standoutAndCVBankBloc.sinkStandoutJobNumber,
                      standoutAndCVBankBloc.incrementStandoutJobNum,
                      standoutAndCVBankBloc.decrementStandoutJobNum,
                      '5'),
                  SizedBox(
                    height: 30.0,
                  ),
                  //Amount row
                  StreamBuilder(
                      stream: standoutAndCVBankBloc.getStandoutJobFee,
                      builder: (context, snapshot) {
                        return Commons.showAmount(
                            'Amount',
                            snapshot.hasData && snapshot.data != null
                                ? '${snapshot.data}'
                                : '0.0');
                      }),
                  StreamBuilder(
                      stream: standoutAndCVBankBloc.showDiscountForStandout,
                      builder: (context, snapshot) {
                        return Commons.showDiscount('${snapshot.data}%');
                      }),
                  SizedBox(
                    height: 30.0,
                  ),
                  StreamBuilder(
                      stream: standoutAndCVBankBloc.cvNum,
                      builder: (context, cvNumSnapshot) {
                        return StreamBuilder(
                            stream: standoutAndCVBankBloc.cvFee,
                            builder: (context, cvFeeSnapshot) {
                              return Commons.cvCount('${cvNumSnapshot.data}',
                                  '${cvFeeSnapshot.data}');
                            });
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder(
                      stream: standoutAndCVBankBloc.getValidity,
                      builder: (context, snapshot) {
                        return Commons.validitySelection(
                            snapshot,
                            standoutAndCVBankBloc.getSelectedMonth,
                            standoutAndCVBankBloc.sinkSelectedMonth);
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
                      stream: standoutAndCVBankBloc.getSubTotal,
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
                      stream: standoutAndCVBankBloc.getVat,
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
              )
            ],
          )),
          StreamBuilder(
              stream: standoutAndCVBankBloc.getSubTotalPlusVat,
              builder: (context, snapshot) {
                return Commons.totalAmountBottom(
                    snapshot.hasData && snapshot.data != null
                        ? '${snapshot.data}'
                        : '0.0');
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    standoutAndCVBankBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    standoutAndCVBankBloc = BlocProvider.of(context);
    standoutAndCVBankBloc.sinkStandoutJobNumber('5');
  }
}
