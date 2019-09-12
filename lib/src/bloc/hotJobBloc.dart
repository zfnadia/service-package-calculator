import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';
import 'package:service_package_calculator/src/repository.dart';

class HotJobBloc extends BlocBase {
  //to get comma separated currency value
  final oCcy = NumberFormat("#,##0.00", "en_US");
  double calculatedBasicFee = 0;
  double calculatedPremiumFee = 0;
  double subTotal = 0;
  double subTotalVat = 0;
  double subTotalPlusVatAmount = 0;

  //-------------------BehaviorSubjects-----------------------------------------

  final _basicJobNum = BehaviorSubject<String>();
  final _premiumJobNum = BehaviorSubject<String>();
  final _basicJobFee = BehaviorSubject<String>();
  final _premiumJobFee = BehaviorSubject<String>();
  final _vat = BehaviorSubject<String>();
  final _subTotal = BehaviorSubject<String>();
  final _subTotalPlusVat = BehaviorSubject<String>();
  final _showDiscountForBasic = BehaviorSubject<String>();
  final _showDiscountForPremium = BehaviorSubject<String>();

  //-----------------------Stream-----------------------------------------------

  Stream<String> get getBasicJobNum => _basicJobNum.stream;

  Stream<String> get getPremiumJobNum => _premiumJobNum.stream;

  Stream<String> get getBasicJobFee => _basicJobFee.stream;

  Stream<String> get getPremiumJobFee => _premiumJobFee.stream;

  Stream<String> get getVat => _vat.stream;

  Stream<String> get getSubTotal => _subTotal.stream;

  Stream<String> get getSubTotalPlusVat => _subTotalPlusVat.stream;

  Stream<String> get showDiscountForBasic => _showDiscountForBasic.stream;

  Stream<String> get showDiscountForPremium => _showDiscountForPremium.stream;

  //-----------------------Function---------------------------------------------

  void sinkBasicJobNumber(String jobNum, int index) async {
    _basicJobNum.sink.add(jobNum);
    int selectedJobNum = int.tryParse(_basicJobNum.value);
    if (selectedJobNum == 0 || selectedJobNum == null) {
      getBasicCalculation(0);
      sinkShowDiscountBasic('false');
    } else if (selectedJobNum == 1) {
      sinkShowDiscountBasic('false');
      getBasicCalculation(1);
    } else if (selectedJobNum == 2) {
      sinkShowDiscountBasic('25%');
      getBasicCalculation(0.75);
    } else if (selectedJobNum == 3) {
      sinkShowDiscountBasic('~ 40.91%');
      getBasicCalculation(0.590909091);
    } else if (selectedJobNum == 4) {
      sinkShowDiscountBasic('~ 43.18%');
      getBasicCalculation(0.568181818);
    } else if (selectedJobNum == 5) {
      sinkShowDiscountBasic('~ 44.55%');
      getBasicCalculation(0.554545454);
    } else if (selectedJobNum == 6 || selectedJobNum >= 7) {
      sinkShowDiscountBasic('~ 50.90%');
      getBasicCalculation(0.490909091);
    }
  }

  void sinkPremiumJobNumber(String jobNum, int index) {
    _premiumJobNum.sink.add(jobNum);
    int selectedJobNum = int.tryParse(_premiumJobNum.value);
    if (selectedJobNum == 0 || selectedJobNum == null) {
      getPremiumCalculation(0);
      sinkShowDiscountPremium('false');
    } else if (selectedJobNum == 1) {
      getPremiumCalculation(1);
      sinkShowDiscountPremium('false');
    } else if (selectedJobNum == 2) {
      sinkShowDiscountPremium('25%');
      getPremiumCalculation(0.75);
    } else if (selectedJobNum == 3) {
      sinkShowDiscountPremium('40%');
      getPremiumCalculation(0.60);
    } else if (selectedJobNum == 4) {
      sinkShowDiscountPremium('43%');
      getPremiumCalculation(0.57);
    } else if (selectedJobNum == 5) {
      sinkShowDiscountPremium('45%');
      getPremiumCalculation(0.55);
    } else if (selectedJobNum == 6 || selectedJobNum >= 7) {
      sinkShowDiscountPremium('51%');
      getPremiumCalculation(0.49);
    }
  }

  Function(String) get sinkBasicJobFee => _basicJobFee.sink.add;

  Function(String) get sinkPremiumJobFee => _premiumJobFee.sink.add;

  Function(String) get sinkVat => _vat.sink.add;

  Function(String) get sinkSubTotal => _subTotal.sink.add;

  Function(String) get sinkSubTotalPlusVat => _subTotalPlusVat.sink.add;

  Function(String) get sinkShowDiscountBasic => _showDiscountForBasic.sink.add;

  Function(String) get sinkShowDiscountPremium =>
      _showDiscountForPremium.sink.add;

  //--------------------------------------------------------------------

  void incrementBasicJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(_basicJobNum.value == null || _basicJobNum.value.isEmpty ? '0' : _basicJobNum.value);
    if (jobNum >= 0 && jobNum < 9999) {
      jobNum++;
      sinkBasicJobNumber(jobNum.toString(), index);
    }
  }

  void incrementPremiumJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(_premiumJobNum.value == null || _premiumJobNum.value.isEmpty ? '0' : _premiumJobNum.value);
    if (jobNum >= 0 && jobNum < 9999) {
      jobNum++;
      sinkPremiumJobNumber(jobNum.toString(), index);
    }
  }

  void decrementBasicJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(_basicJobNum.value == null || _basicJobNum.value.isEmpty ? '0' : _basicJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkBasicJobNumber(jobNum.toString(), index);
    }
  }

  void decrementPremiumJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(_premiumJobNum.value == null || _premiumJobNum.value.isEmpty ? '0' : _premiumJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkPremiumJobNumber(jobNum.toString(), index);
    }
  }

  void getBasicCalculation(double discount) async {
    var servicePackageModel = await repository.getServicePackageModel();
    int basicRate = servicePackageModel.jobListing.hotJob.normalRate;
    int jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum == null) {
      jobNum = 0;
    }
    calculatedBasicFee = (jobNum * basicRate * discount);
    sinkBasicJobFee(oCcy.format(calculatedBasicFee).toString());
    calculateSubTotal();
    calculateVat();
    calculateSubTotalPlusVat();
  }

  void getPremiumCalculation(double discount) async {
    var servicePackageModel = await repository.getServicePackageModel();
    int premiumRate = servicePackageModel.jobListing.hotJob.premiumRate;
    int jobNum = int.tryParse(_premiumJobNum.value);
    if (jobNum == null) {
      jobNum = 0;
    }

    calculatedPremiumFee = (jobNum * premiumRate * discount);
    sinkPremiumJobFee(oCcy.format(calculatedPremiumFee).toString());
    calculateSubTotal();
    calculateVat();
    calculateSubTotalPlusVat();
  }

  void calculateSubTotal() {
    subTotal = calculatedBasicFee + calculatedPremiumFee;
    sinkSubTotal(oCcy.format(subTotal).toString());
  }

  void calculateVat() {
    subTotalVat = subTotal * 0.05;
    sinkVat(oCcy.format(subTotalVat).toString());
  }

  void calculateSubTotalPlusVat() {
    subTotalPlusVatAmount = subTotal + subTotalVat;
    sinkSubTotalPlusVat(oCcy.format(subTotalPlusVatAmount).toString());
    subTotalPlusVatAmount = 0;
  }

  @override
  void dispose() {
    _basicJobNum.close();
    _basicJobFee.close();
    _premiumJobFee.close();
    _premiumJobNum.close();
    _subTotal.close();
    _subTotalPlusVat.close();
    _vat.close();
    _showDiscountForBasic.close();
    _showDiscountForPremium.close();
  }

  void clearAllData() {
    _basicJobNum.value = null;
    _basicJobFee.value = null;
    _premiumJobFee.value = null;
    _premiumJobNum.value = null;
    _subTotal.value = null;
    _subTotalPlusVat.value = null;
    _vat.value = null;
    calculatedBasicFee = 0;
    calculatedPremiumFee = 0;
    subTotal = 0;
    subTotalVat = 0;
    subTotalPlusVatAmount = 0;
    _showDiscountForBasic.value = null;
    _showDiscountForPremium.value = null;
  }
}
