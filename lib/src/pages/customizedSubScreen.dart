import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/customizedJobBloc.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';

class CustomizedSubscription extends StatefulWidget {
  @override
  _CustomizedSubscriptionState createState() => _CustomizedSubscriptionState();
}

class _CustomizedSubscriptionState extends State<CustomizedSubscription> {
  CustomizedJobBloc customizedJobBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bulk Subscription: \nCustomized',
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
/*                  Commons.switchBDTtoDollar(),
                  SizedBox(
                    height: 20.0,
                  ),*/
                  Commons.editJobAmount(
                      'Basic Jobs',
                      customizedJobBloc.getBasicJobNum,
                      customizedJobBloc.sinkBasicJobNumber,
                      customizedJobBloc.incrementBasicJobNum,
                      customizedJobBloc.decrementBasicJobNum,
                      'customBasicInc',
                      'customBasicDec',
                      '0'),
                  SizedBox(
                    height: 30.0,
                  ),
                  //Amount row
                  StreamBuilder(
                      stream: customizedJobBloc.getBasicJobFee,
                      builder: (context, snapshot) {
                        return Commons.showAmount(
                            'Amount',
                            snapshot.hasData && snapshot.data != null
                                ? '${snapshot.data}'
                                : '0.0', 'customBasicAmnt');
                      }),
                  StreamBuilder(
                      stream: customizedJobBloc.showDiscountForBasic,
                      builder: (context, snapshot) {
                        return Commons.showDiscount('${snapshot.data}%');
                      }),
                  SizedBox(
                    height: 30.0,
                  ),
                  Commons.editJobAmount(
                      'Standout Jobs',
                      customizedJobBloc.getStandoutJobNum,
                      customizedJobBloc.sinkStandoutJobNumber,
                      customizedJobBloc.incrementStandoutJobNum,
                      customizedJobBloc.decrementStandoutJobNum,
                      'customStandoutInc',
                      'customStandoutDec',
                      '0'),
                  SizedBox(
                    height: 30.0,
                  ),
                  //Amount row
                  StreamBuilder(
                      stream: customizedJobBloc.getStandoutJobFee,
                      builder: (context, snapshot) {
                        return Commons.showAmount(
                            'Amount',
                            snapshot.hasData && snapshot.data != null
                                ? '${snapshot.data}'
                                : '0.0', 'customStandoutAmnt');
                      }),
                  StreamBuilder(
                      stream: customizedJobBloc.showDiscountForStandout,
                      builder: (context, snapshot) {
                        return Commons.showDiscount('${snapshot.data}%');
                      }),
                  SizedBox(
                    height: 30.0,
                  ),
                  StreamBuilder(
                      stream: customizedJobBloc.getCVNum,
                      builder: (context, cvNumSnapshot) {
                        return StreamBuilder(
                            stream: customizedJobBloc.getCVFee,
                            builder: (context, cvFeeSnapshot) {
                              return StreamBuilder(
                                  stream: customizedJobBloc.getCvStatus,
                                  builder: (context, cvStatusSnapshot) {
                                    print('CV STATUS ${cvStatusSnapshot.data}');
                                    return Commons.cvCount(
                                        '${cvNumSnapshot.data}',
                                        '${cvFeeSnapshot.data}',
                                        cvStatusSnapshot.data,
                                        customizedJobBloc.sinkCVStatus,
                                        1);
                                  });
                            });
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder(
                      stream: customizedJobBloc.getValidity,
                      builder: (context, snapshot) {
                        return Commons.validitySelection(
                            snapshot,
                            customizedJobBloc.getSelectedMonth,
                            customizedJobBloc.sinkSelectedMonth);
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
                      stream: customizedJobBloc.getSubTotal,
                      builder: (context, snapshot) {
                        return Commons.showAmount('Sub Total', snapshot.data, 'customSubTotal');
                      }),
                  SizedBox(
                    height: 30.0,
                  ),
                  StreamBuilder(
                      stream: customizedJobBloc.getVatOnSubTotal,
                      builder: (context, snapshot) {
                        return Commons.showAmount('VAT (5%)', snapshot.data, 'customVat');
                      }),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              )
            ],
          )),
          StreamBuilder(
              stream: customizedJobBloc.getSubTotalPlusVat,
              builder: (context, snapshot) {
                return Commons.totalAmountBottom(snapshot.data);
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    customizedJobBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    customizedJobBloc = BlocProvider.of(context);
    customizedJobBloc.sinkBasicJobNumber('0', 0);
    customizedJobBloc.sinkStandoutJobNumber('0', 0);

    customizedJobBloc.sinkBasicJobFee('0');
    customizedJobBloc.sinkStandoutJobFee('0');
    customizedJobBloc.sinkShowDiscountBasic('0');
    customizedJobBloc.sinkShowDiscountStandout('0');
    customizedJobBloc.sinkCVNum('0');
    customizedJobBloc.sinkCVFee('0');
    customizedJobBloc.sinkSubTotal('0.0');
    customizedJobBloc.sinkVatOnSubTotal('0.0');
    customizedJobBloc.sinkSubTotalPlusVat('0.0');
    customizedJobBloc.sinkCVStatus(false, 1);
  }
}
