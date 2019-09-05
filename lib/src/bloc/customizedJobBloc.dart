import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:service_package_calculator/src/model/servicePackageModel.dart';
import 'package:service_package_calculator/src/utilities/commonMethods.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';
import '../repository.dart';

class CustomizedJobBloc extends BlocBase {
  //-------------------BehaviorSubjects-----------------------------------------
  //-------------------Basic-----------------------------------------
  final _basicJobNum = BehaviorSubject<String>();
  final _basicJobFee = BehaviorSubject<String>();
  final _showDiscountForBasic = BehaviorSubject<String>();
  final _selectedMonthBasic = BehaviorSubject<String>();

  //-------------------Standout-----------------------------------------
  final _standoutJobNum = BehaviorSubject<String>();
  final _standoutJobFee = BehaviorSubject<String>();
  final _showDiscountForStandout = BehaviorSubject<String>();
  final _selectedMonthStandout = BehaviorSubject<String>();

  //-----------------------Common-----------------------------------------------
  final _cvNum = BehaviorSubject<String>();
  final _cvFee = BehaviorSubject<String>();
  final _subTotal = BehaviorSubject<String>();
  final _vatOnSubTotal = BehaviorSubject<String>();
  final _subTotalPlusVat = BehaviorSubject<String>();
  final _validity = BehaviorSubject<List<int>>();
  final _selectedMonth = BehaviorSubject<String>();

  //-----------------------Stream-----------------------------------------------
  Stream<String> get getBasicJobNum => _basicJobNum.stream;

  Stream<String> get getBasicJobFee => _basicJobFee.stream;

  Stream<String> get showDiscountForBasic => _showDiscountForBasic.stream;

  Stream<String> get getSelectedMonthBasic => _selectedMonthBasic.stream;

  //-------------------Standout-----------------------------------------
  Stream<String> get getStandoutJobNum => _standoutJobNum.stream;

  Stream<String> get getStandoutJobFee => _standoutJobFee.stream;

  Stream<String> get showDiscountForStandout => _showDiscountForStandout.stream;

  Stream<String> get getSelectedMonthStandout => _selectedMonthStandout.stream;

  //-----------------------Common-----------------------------------------------
  Stream<String> get getCVNum => _cvNum.stream;

  Stream<String> get getCVFee => _cvFee.stream;

  Stream<String> get getSubTotal => _subTotal.stream;

  Stream<String> get getVatOnSubTotal => _vatOnSubTotal.stream;

  Stream<String> get getSubTotalPlusVat => _subTotalPlusVat.stream;

  Stream<List<int>> get getValidity => _validity.stream;

  Stream<String> get getSelectedMonth => _selectedMonth.stream;

  //-----------------------Function---------------------------------------------
  //-----------------------Basic-----------------------------------------
  void sinkBasicJobNumber(String jobNum) async {
//    var jobNumber = 0;
//    jobNumber = int.tryParse(jobNum == null || jobNum.isEmpty ? '0' : jobNum);

    _basicJobNum.sink.add(jobNum.toString());
    print('LLLLLLLLLLLLLLLLLLBBB ${_basicJobNum.value}');

    getMonthAndJobNumCalculation(findMonthToSink(_basicJobNum.value),
        int.tryParse(_basicJobNum.value), 0);
  }

  Function(String) get sinkBasicJobFee => _basicJobFee.sink.add;

  Function(String) get sinkShowDiscountBasic => _showDiscountForBasic.sink.add;

  //-------------------Standout-----------------------------------------

  void sinkStandoutJobNumber(String jobNum) async {
    var jn = 0;
    jn = int.tryParse(jobNum == null || jobNum.isEmpty ? '0' : jobNum);

    _standoutJobNum.sink.add(jn.toString());
    getMonthAndJobNumCalculation(findMonthToSink(_standoutJobNum.value),
        int.tryParse(_standoutJobNum.value), 1);
  }

  Function(String) get sinkStandoutJobFee => _standoutJobFee.sink.add;

  Function(String) get sinkShowDiscountStandout =>
      _showDiscountForStandout.sink.add;

  //-------------------Common-----------------------------------------

  Function(String) get sinkCVNum => _cvNum.sink.add;

  Function(String) get sinkCVFee => _cvFee.sink.add;

  Function(String) get sinkSubTotal => _subTotal.sink.add;

  Function(String) get sinkVatOnSubTotal => _vatOnSubTotal.sink.add;

  Function(String) get sinkSubTotalPlusVat => _subTotalPlusVat.sink.add;

  Function(List<int>) get sinkValidity => _validity.sink.add;

  void sinkSelectedMonth(String month) {
    _selectedMonth.sink.add(month);
  }

  //-----------------------------Other Functions---------------------------------------
  void incrementBasicJobNum() {
    int jobNum = 0;
    jobNum =
        int.tryParse(_basicJobNum.value == null ? '0' : _basicJobNum.value);
    if (jobNum >= 0) {
      jobNum++;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void decrementBasicJobNum() {
    int jobNum = 0;
    jobNum =
        int.tryParse(_basicJobNum.value == null ? '0' : _basicJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void incrementStandoutJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(
        _standoutJobNum.value == null ? '0' : _standoutJobNum.value);
    if (jobNum >= 0) {
      jobNum++;
      sinkStandoutJobNumber(jobNum.toString());
    }
  }

  void decrementStandoutJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(
        _standoutJobNum.value == null ? '0' : _standoutJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkStandoutJobNumber(jobNum.toString());
    }
  }

  int totalJobs() {
    int basicJobNum = 0;
    int standoutJobNum = 0;
    basicJobNum =
        int.tryParse(_basicJobNum.value == null || _basicJobNum.value.isEmpty ? '0' : _basicJobNum.value);
    standoutJobNum = int.tryParse(
        _standoutJobNum.value == null || _standoutJobNum.value.isEmpty ? '0' : _standoutJobNum.value);
    return basicJobNum + standoutJobNum;
  }

  String findMonthToSink(String jobNum) {
    int selectedJobNum = int.tryParse(jobNum);
    if (selectedJobNum == null) {
      return '0';
    } else if (selectedJobNum >= 0 && selectedJobNum < 5) {
      return '0';
    } else if (selectedJobNum < 20) {
      return '6';
    } else if (selectedJobNum >= 20 && selectedJobNum < 30) {
      return '9';
    } else if (selectedJobNum >= 30) {
      return '12';
    }
    return '0';
  }

  void validityCalculation(int selectedJobNum) async {
    if (selectedJobNum == null) {
      sinkValidity(Constants.empty);
      sinkSelectedMonth('0');
    } else if (selectedJobNum >= 0 && selectedJobNum < 5) {
      sinkValidity(Constants.empty);
      sinkSelectedMonth('0');
    } else if (selectedJobNum < 20) {
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

  void getMonthAndJobNumCalculation(
      String month, int selectedJobNum, int packageIndex) async {
    var servicePackageModel = await repository.getServicePackageModel();
    if (selectedJobNum == null) {
      selectedJobNum = 0;
    }

    Rate cvPackage = CommonMethods.getServicePackageRateWithoutMonth(
        totalJobs(), servicePackageModel.jobListing.bulk[packageIndex].rates);

    sinkCVNum(cvPackage.cv.toString());
    sinkCVFee(cvPackage.cvFee.toString());

    print('cv count: ${cvPackage.cv} cv fee: ${cvPackage.cvFee}');

    Rate servicePackage = CommonMethods.getServicePackageRate(
        month,
        selectedJobNum,
        servicePackageModel.jobListing.bulk[packageIndex].rates);
    int basicRate = servicePackage.rate;
    int discount = servicePackage.discount;
    int calculatedBasicFee = (selectedJobNum * basicRate);

    if (packageIndex == 0) {
      sinkBasicJobFee(calculatedBasicFee.toString());
      sinkShowDiscountBasic(Constants.oCcy1.format(discount).toString());
    } else {
      sinkStandoutJobFee(calculatedBasicFee.toString());
      sinkShowDiscountStandout(discount.toString());
    }

    totalAmountCalculation();
    validityCalculation(totalJobs());
  }

  void totalAmountCalculation() {
    int basicJobFee = 0;
    int standOutJobFee = 0;
    int cvFee = 0;
    basicJobFee = int.tryParse(_basicJobFee.value);
    standOutJobFee = int.tryParse(_standoutJobFee.value);
    cvFee = int.tryParse(_cvFee.value);
    int subTotal = basicJobFee + standOutJobFee + cvFee;
    double vatOnSubTotal = subTotal * 0.05;
    double subTotalPlusVat = subTotal + vatOnSubTotal;
    sinkSubTotal(Constants.oCcy.format(subTotal).toString());
    sinkVatOnSubTotal(Constants.oCcy.format(vatOnSubTotal).toString());
    sinkSubTotalPlusVat(Constants.oCcy.format(subTotalPlusVat).toString());
    print('SubTotal $subTotal');
    print('SubtotalVat $vatOnSubTotal');
    print('SubTotalPlus VAT $subTotalPlusVat');
  }

  @override
  void dispose() {
    _basicJobNum.close();
    _basicJobFee.close();
    _showDiscountForBasic.close();
    _selectedMonthBasic.close();
    _standoutJobNum.close();
    _standoutJobFee.close();
    _showDiscountForStandout.close();
    _cvNum.close();
    _cvFee.close();
    _selectedMonthStandout.close();
    _subTotal.close();
    _subTotalPlusVat.close();
    _vatOnSubTotal.close();
    _validity.close();
    _selectedMonth.close();
  }

  void clearAllData() {
    _basicJobNum.value = null;
    _basicJobFee.value = null;
    _showDiscountForBasic.value = null;
    _selectedMonthBasic.value = null;
    _standoutJobNum.value = null;
    _standoutJobFee.value = null;
    _showDiscountForStandout.value = null;
    _cvNum.value = null;
    _cvFee.value = null;
    _selectedMonthStandout.value = null;
    _subTotal.value = null;
    _subTotalPlusVat.value = null;
    _vatOnSubTotal.value = null;
    _validity.value = null;
    _selectedMonth.value = null;
  }
}
