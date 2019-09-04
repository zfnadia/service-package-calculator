import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/basicAndCVBankBloc.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/routes/routes.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class BasicAndCVBankSub extends StatefulWidget {
  @override
  _BasicAndCVBankSubState createState() => _BasicAndCVBankSubState();
}

class _BasicAndCVBankSubState extends State<BasicAndCVBankSub> {
  BasicAndCVBankBloc basicAndCVBankBloc;

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
                      'Basic Jobs',
                      basicAndCVBankBloc.getBasicJobNum,
                      basicAndCVBankBloc.sinkBasicJobNumber,
                      basicAndCVBankBloc.incrementBasicJobNum,
                      basicAndCVBankBloc.decrementBasicJobNum,
                      '5'),
                  SizedBox(
                    height: 30.0,
                  ),
                  //Amount row
                  StreamBuilder(
                      stream: basicAndCVBankBloc.getBasicJobFee,
                      builder: (context, snapshot) {
                        return Commons.showAmount(
                            'Amount',
                            snapshot.hasData && snapshot.data != null
                                ? '${snapshot.data}'
                                : '0.0');
                      }),
                  StreamBuilder(
                      stream: basicAndCVBankBloc.showDiscountForBasic,
                      builder: (context, snapshot) {
                        return Commons.showDiscount('${snapshot.data}%');
                      }),
                  SizedBox(
                    height: 30.0,
                  ),
                  StreamBuilder(
                      stream: basicAndCVBankBloc.cvNum,
                      builder: (context, cvNumSnapshot) {
                        return StreamBuilder(
                            stream: basicAndCVBankBloc.cvFee,
                            builder: (context, cvFeeSnapshot) {
                              return Commons.cvCount('${cvNumSnapshot.data}',
                                  '${cvFeeSnapshot.data}');
                            });
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder(
                      stream: basicAndCVBankBloc.getValidity,
                      builder: (context, snapshot) {
                        return Commons.validitySelection(
                            snapshot,
                            basicAndCVBankBloc.getSelectedMonth,
                            basicAndCVBankBloc.sinkSelectedMonth);
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
                      stream: basicAndCVBankBloc.getSubTotal,
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
                      stream: basicAndCVBankBloc.getVat,
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
              stream: basicAndCVBankBloc.getSubTotalPlusVat,
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
    basicAndCVBankBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    basicAndCVBankBloc = BlocProvider.of(context);
    basicAndCVBankBloc.sinkBasicJobNumber('5');
  }
}
