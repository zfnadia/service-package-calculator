import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:service_package_calculator/src/model/servicePackageModel.dart';
import 'package:service_package_calculator/src/utilities/commonMethods.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';
import '../repository.dart';

class CustomizedJobBloc extends BlocBase {
  //-------------------BehaviorSubjects-----------------------------------------
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

  //-----------------------Function---------------------------------------------

  void sinkBasicJobNumber(String jobNum) async {
    var jn = 0;
    jn = int.tryParse(jobNum == null || jobNum.isEmpty ? '0' : jobNum);

    _basicJobNum.sink.add(jn.toString());
    getMonthAndJobNumCalculation(findMonthToSink(_basicJobNum.value),
        int.tryParse(_basicJobNum.value), 0);
  }

  void sinkStandoutJobNumber(String jobNum) async {
    var jn = 0;
    jn = int.tryParse(jobNum == null || jobNum.isEmpty ? '0' : jobNum);

    _standoutJobNum.sink.add(jn.toString());
    getMonthAndJobNumCalculation(findMonthToSink(_standoutJobNum.value),
        int.tryParse(_standoutJobNum.value), 1);
  }

  String findMonthToSink(String jobNum) {
    int selectedJobNum = int.tryParse(jobNum);
    if (selectedJobNum < 20) {
      return '6';
    } else if (selectedJobNum >= 20 && selectedJobNum < 30) {
      return '9';
    } else if (selectedJobNum >= 30) {
      return '12';
    }
    return '0';
  }

  void sinkSelectedMonthBasic(String month) {
    _selectedMonthBasic.sink.add(month);
  }

  void sinkSelectedMonthStandout(String month) {
    _selectedMonthStandout.sink.add(month);
  }

  Function(String) get sinkBasicJobFee => _basicJobFee.sink.add;

  Function(String) get sinkShowDiscountBasic => _showDiscountForBasic.sink.add;

  Function(String) get sinkStandoutJobFee => _standoutJobFee.sink.add;

  Function(String) get sinkShowDiscountStandout =>
      _showDiscountForStandout.sink.add;

  Function(String) get sinkCVNum => _cvNum.sink.add;

  Function(String) get sinkCVFee => _cvFee.sink.add;

  Function(String) get sinkSubTotal => _subTotal.sink.add;

  Function(String) get sinkVatOnSubTotal => _vatOnSubTotal.sink.add;

  Function(String) get sinkSubTotalPlusVat => _subTotalPlusVat.sink.add;

//  Function(List<int>) get sinkValidity => _validity.sink.add;
  //--------------------------------------------------------------------

  void incrementBasicJobNum() {
    int jobNum = 0;
    jobNum =
        int.tryParse(_basicJobNum.value == null ? '5' : _basicJobNum.value);
    if (jobNum >= 5) {
      jobNum++;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void decrementBasicJobNum() {
    int jobNum = 0;
    jobNum =
        int.tryParse(_basicJobNum.value == null ? '5' : _basicJobNum.value);
    if (jobNum > 5) {
      jobNum--;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void incrementStandoutJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(
        _standoutJobNum.value == null ? '5' : _standoutJobNum.value);
    if (jobNum >= 5) {
      jobNum++;
      sinkStandoutJobNumber(jobNum.toString());
    }
  }

  int totalJobs() {
    int bjn = 0;
    int sjn = 0;
    bjn = int.tryParse(_basicJobNum.value == null ? '5' : _basicJobNum.value);
    sjn = int.tryParse(
        _standoutJobNum.value == null ? '5' : _standoutJobNum.value);
    return bjn + sjn;
  }

  void decrementStandoutJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(
        _standoutJobNum.value == null ? '5' : _standoutJobNum.value);
    if (jobNum > 5) {
      jobNum--;
      sinkStandoutJobNumber(jobNum.toString());
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

  void getCVCalculation(String month, int totalJobNum, int packageIndex) async {
    var servicePackageModel = await repository.getServicePackageModel();
    if (totalJobNum == null) {
      totalJobNum = 0;
    }
    var servicePackage = CommonMethods.getServicePackageRate(month, totalJobNum,
        servicePackageModel.jobListing.bulk[packageIndex].rates);
    int cvFee = servicePackage.cvFee;
    int cvNum = servicePackage.cv;
    print("CV Num $cvNum");
    print("CV Fee $cvFee");
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
  }

  void clearAllData() {
    _basicJobNum.value = '5';
    _basicJobFee.value = null;
    _showDiscountForBasic.value = null;
    _selectedMonthBasic.value = '0';
    _standoutJobNum.value = '5';
    _standoutJobFee.value = null;
    _showDiscountForStandout.value = null;
    _cvNum.value = null;
    _cvFee.value = null;
    _selectedMonthStandout.value = '0';
    _subTotal.value = null;
    _subTotalPlusVat.value = null;
    _vatOnSubTotal.value = null;
  }
}
