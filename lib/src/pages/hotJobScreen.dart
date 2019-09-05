import 'package:flutter/material.dart';
import 'package:service_package_calculator/src/bloc/hotJobBloc.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/utilities/commonWidgets.dart';

class HotJobSubscription extends StatefulWidget {
  @override
  _HotJobSubscriptionState createState() => _HotJobSubscriptionState();
}

class _HotJobSubscriptionState extends State<HotJobSubscription> {
  HotJobBloc hotJobBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hot Job',
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
/*                    Commons.switchBDTtoDollar(),
                    SizedBox(
                      height: 20.0,
                    ),*/
                    Commons.boldRowTitle('Hot Job'),
                    //Selected Job Number
                    Commons.editJobAmount(
                        'Jobs',
                        hotJobBloc.getBasicJobNum,
                        hotJobBloc.sinkBasicJobNumber,
                        hotJobBloc.incrementBasicJobNum,
                        hotJobBloc.decrementBasicJobNum,
                        '0'),
                    SizedBox(
                      height: 20.0,
                    ),
                    //Amount row
                    StreamBuilder(
                        stream: hotJobBloc.getBasicJobFee,
                        builder: (context, snapshot) {
                          return Commons.showAmount(
                              'Amount',
                              snapshot.hasData && snapshot.data != null
                                  ? '${snapshot.data}'
                                  : '0.0');
                        }),
                    StreamBuilder(
                        stream: hotJobBloc.showDiscountForBasic,
                        builder: (context, snapshot) {
                          return snapshot.hasData && snapshot.data != 'false'
                              ? Commons.showDiscount('${snapshot.data}')
                              : SizedBox();
                        }),
                    SizedBox(
                      height: 30.0,
                    ),
                    Commons.boldRowTitle('Hot Job Premium'),
                    Commons.editJobAmount(
                        'Jobs',
                        hotJobBloc.getPremiumJobNum,
                        hotJobBloc.sinkPremiumJobNumber,
                        hotJobBloc.incrementPremiumJobNum,
                        hotJobBloc.decrementPremiumJobNum,
                        '0'),
                    SizedBox(
                      height: 20.0,
                    ),
                    //Amount row
                    StreamBuilder(
                        stream: hotJobBloc.getPremiumJobFee,
                        builder: (context, snapshot) {
                          return Commons.showAmount(
                              'Amount',
                              snapshot.hasData && snapshot.data != null
                                  ? '${snapshot.data}'
                                  : '0.0');
                        }),
                    StreamBuilder(
                        stream: hotJobBloc.showDiscountForPremium,
                        builder: (context, snapshot) {
                          return snapshot.hasData && snapshot.data != 'false'
                              ? Commons.showDiscount('${snapshot.data}')
                              : SizedBox();
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
                        stream: hotJobBloc.getSubTotal,
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
                        stream: hotJobBloc.getVat,
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
              stream: hotJobBloc.getSubTotalPlusVat,
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
    hotJobBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hotJobBloc = BlocProvider.of(context);
    hotJobBloc.sinkBasicJobNumber('0');
    hotJobBloc.sinkPremiumJobNumber('0');
  }
}
