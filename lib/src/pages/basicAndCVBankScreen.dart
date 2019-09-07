import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/selectedJobAndCVBankBloc.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';

class BasicAndCVBankSub extends StatefulWidget {
  @override
  _BasicAndCVBankSubState createState() => _BasicAndCVBankSubState();
}

class _BasicAndCVBankSubState extends State<BasicAndCVBankSub> {
  SelectedJobAndCVBankBloc selectedAndCVBankBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bulk Subscription: \nBasic Job and CV Bank',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // call this method here to hide soft keyboard
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
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
                        selectedAndCVBankBloc.getSelectedJobNum,
                        selectedAndCVBankBloc.sinkSelectedJobNumber,
                        selectedAndCVBankBloc.incrementSelectedJobNum,
                        selectedAndCVBankBloc.decrementSelectedJobNum,
                        '0', index: 0),
                    SizedBox(
                      height: 30.0,
                    ),
                    //Amount row
                    StreamBuilder(
                        stream: selectedAndCVBankBloc.getSelectedJobFee,
                        builder: (context, snapshot) {
                          return Commons.showAmount(
                              'Amount',
                              snapshot.hasData && snapshot.data != null
                                  ? '${snapshot.data}'
                                  : '0.0');
                        }),
                    StreamBuilder(
                        stream: selectedAndCVBankBloc.showDiscountForBasic,
                        builder: (context, snapshot) {
                          return Commons.showDiscount('${snapshot.data}%');
                        }),
                    SizedBox(
                      height: 30.0,
                    ),
                    StreamBuilder(
                        stream: selectedAndCVBankBloc.cvNum,
                        builder: (context, cvNumSnapshot) {
                          return StreamBuilder(
                              stream: selectedAndCVBankBloc.cvFee,
                              builder: (context, cvFeeSnapshot) {
                                return StreamBuilder(
                                  stream: selectedAndCVBankBloc.getCvStatus,
                                  builder: (context, cvStatusSnapshot) {
                                    print('CV STATUS ${cvStatusSnapshot.data}');
                                    return Commons.cvCount('${cvNumSnapshot.data}',
                                        '${cvFeeSnapshot.data}', cvStatusSnapshot.data,
                                    selectedAndCVBankBloc.sinkCVStatus, 0);
                                  }
                                );
                              });
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    StreamBuilder(
                        stream: selectedAndCVBankBloc.getValidity,
                        builder: (context, snapshot) {
                          return Commons.validitySelection(
                              snapshot,
                              selectedAndCVBankBloc.getSelectedMonth,
                              selectedAndCVBankBloc.sinkSelectedMonth, index: 0);
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
                        stream: selectedAndCVBankBloc.getSubTotal,
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
                        stream: selectedAndCVBankBloc.getVat,
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
                stream: selectedAndCVBankBloc.getSubTotalPlusVat,
                builder: (context, snapshot) {
                  return Commons.totalAmountBottom(
                      snapshot.hasData && snapshot.data != null
                          ? '${snapshot.data}'
                          : '0.0');
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    selectedAndCVBankBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedAndCVBankBloc = BlocProvider.of(context);
    selectedAndCVBankBloc.sinkSelectedJobNumber('0', 0);
    selectedAndCVBankBloc.sinkCVStatus(false, 0);
  }
}
