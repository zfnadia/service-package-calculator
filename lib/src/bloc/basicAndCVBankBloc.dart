import 'package:rxdart/rxdart.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/repository.dart';
import 'package:service_package_calculator/src/utilities/commonMethods.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class BasicAndCVBankBloc extends BlocBase {
  //-------------------BehaviorSubjects-----------------------------------------

  final _basicJobNum = BehaviorSubject<String>();
  final _basicJobFee = BehaviorSubject<String>();
  final _vat = BehaviorSubject<String>();
  final _subTotal = BehaviorSubject<String>();
  final _subTotalPlusVat = BehaviorSubject<String>();
  final _showDiscountForBasic = BehaviorSubject<String>();
  final _cvNum = BehaviorSubject<String>();
  final _cvFee = BehaviorSubject<String>();
  final _validity = BehaviorSubject<List<int>>();
  final _selectedMonth = BehaviorSubject<String>();

  //-----------------------Stream-----------------------------------------------

  Stream<String> get getBasicJobNum => _basicJobNum.stream;

  Stream<String> get getBasicJobFee => _basicJobFee.stream;

  Stream<String> get getVat => _vat.stream;

  Stream<String> get getSubTotal => _subTotal.stream;

  Stream<String> get getSubTotalPlusVat => _subTotalPlusVat.stream;

  Stream<String> get showDiscountForBasic => _showDiscountForBasic.stream;

  Stream<String> get cvNum => _cvNum.stream;

  Stream<String> get cvFee => _cvFee.stream;

  Stream<List<int>> get getValidity => _validity.stream;

  Stream<String> get getSelectedMonth => _selectedMonth.stream;

  //-----------------------Function---------------------------------------------

  void sinkBasicJobNumber(String jobNum) async {
    _basicJobNum.sink.add(jobNum);

    //calculationLogic(selectedJobNum, _selectedMonth.value);
    int selectedJobNum = int.tryParse(_basicJobNum.value);
    if (selectedJobNum < 20) {
      sinkValidity(Constants.sixMonth);
      sinkSelectedMonth('6');
    } else if (selectedJobNum == 20) {
      sinkValidity(Constants.sixNineMonths);
      sinkSelectedMonth('9');
    } else if (selectedJobNum > 20 && selectedJobNum < 30) {
      sinkValidity(Constants.nineMonth);
      sinkSelectedMonth('9');
    } else if (selectedJobNum == 30) {
      sinkValidity(Constants.nineTwelveMonths);
      sinkSelectedMonth('12');
    } else if (selectedJobNum > 30) {
      sinkValidity(Constants.twelveMonth);
      sinkSelectedMonth('12');
    }
  }

  void sinkSelectedMonth(String month) {
    _selectedMonth.sink.add(month);
    int selectedJobNum = int.tryParse(_basicJobNum.value);
    getMonthAndJobNumCalculation(_selectedMonth.value, selectedJobNum);
  }

  Function(String) get sinkBasicJobFee => _basicJobFee.sink.add;

  Function(String) get sinkVat => _vat.sink.add;

  Function(String) get sinkSubTotal => _subTotal.sink.add;

  Function(String) get sinkSubTotalPlusVat => _subTotalPlusVat.sink.add;

  Function(String) get sinkShowDiscountBasic => _showDiscountForBasic.sink.add;

  Function(String) get sinkCVNum => _cvNum.sink.add;

  Function(String) get sinkCVFee => _cvFee.sink.add;

  Function(List<int>) get sinkValidity => _validity.sink.add;

  //--------------------------------------------------------------------

  void incrementBasicJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum >= 5) {
      jobNum++;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void decrementBasicJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum > 5) {
      jobNum--;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void getMonthAndJobNumCalculation(String month, int selectedJobNum) async {
    print('GOT VALUE month= $month selectedJobNum= $selectedJobNum');

    var servicePackageModel = await repository.getServicePackageModel();

    if (selectedJobNum == null) {
      selectedJobNum = 0;
    }

    var servicePackage = CommonMethods.getServicePackageRate(
        month, selectedJobNum, servicePackageModel.jobListing.bulk[0].rates);

    print('GOT VALUE Final = ${servicePackage.rate}');

    int vat = servicePackageModel.vat;
    int basicRate = servicePackage.rate;
    int discount = servicePackage.discount;
    int cvNum = servicePackage.cv;
    int cvFee = servicePackage.cvFee;
    int calculatedBasicFee = (selectedJobNum * basicRate);
    int subTotal = calculatedBasicFee + cvFee;
    double subTotalVat = subTotal * (vat / 100);
    double subTotalPlusVat = subTotal + subTotalVat;
    sinkBasicJobFee(Constants.oCcy.format(calculatedBasicFee).toString());
    sinkShowDiscountBasic(Constants.oCcy1.format(discount).toString());
    sinkCVNum(Constants.oCcy1.format(cvNum).toString());
    sinkCVFee(Constants.oCcy.format(cvFee).toString());
    sinkSubTotal(Constants.oCcy.format(subTotal).toString());
    sinkVat(Constants.oCcy.format(subTotalVat).toString());
    sinkSubTotalPlusVat(Constants.oCcy.format(subTotalPlusVat).toString());
    print('VAT $vat');
    print('basicRate $basicRate');
    print('discount $discount');
    print('cvNum $cvNum');
    print('cvFee $cvFee');
    print('calculatedBasicFee $calculatedBasicFee');
    print('subTotal $subTotal');
    print('subTotalVat $subTotalVat');
    print('subTotalPlusVat $subTotalPlusVat');
  }

  @override
  void dispose() {
    _basicJobNum.close();
    _basicJobFee.close();
    _subTotal.close();
    _subTotalPlusVat.close();
    _vat.close();
    _showDiscountForBasic.close();
    _cvNum.close();
    _cvFee.close();
    _validity.close();
    _selectedMonth.close();
  }

  void clearAllData() {
    _basicJobNum.value = '0';
    _basicJobFee.value = null;
    _subTotal.value = null;
    _subTotalPlusVat.value = null;
    _vat.value = null;
    _showDiscountForBasic.value = null;
    _cvNum.value = null;
    _cvFee.value = null;
    _validity.value = null;
    _selectedMonth.value = '0';
  }
}
