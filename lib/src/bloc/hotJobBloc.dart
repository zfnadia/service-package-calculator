import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';
import 'package:service_package_calculator/src/repository.dart';

class HotJobBloc extends BlocBase {
  //to get comma separated currency value
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  int jobNum = 0;
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

  //-----------------------Stream-----------------------------------------------

  Stream<String> get  getBasicJobNum => _basicJobNum.stream;

  Stream<String> get getPremiumJobNum => _premiumJobNum.stream;

  Stream<String> get getBasicJobFee => _basicJobFee.stream;

  Stream<String> get getPremiumJobFee => _premiumJobFee.stream;

  Stream<String> get getVat => _vat.stream;

  Stream<String> get getSubTotal => _subTotal.stream;

  Stream<String> get getSubTotalPlusVat => _subTotalPlusVat.stream;

  //-----------------------Function---------------------------------------------

  void sinkBasicJobNumber(String jobNum) async {
    _basicJobNum.sink.add(jobNum);
    int selectedJobNum = int.tryParse(_basicJobNum.value);
    print('JJJJJJJJJJJJJJ ${selectedJobNum}');
    if(selectedJobNum == 0) {
      getBasicCalculation(0);
    } else if (selectedJobNum == 1) {
      getBasicCalculation(1);
    } else if (selectedJobNum == 2) {
      getBasicCalculation(0.75);
    } else if (selectedJobNum == 3) {
      getBasicCalculation(0.59);
    } else if (selectedJobNum == 4) {
      getBasicCalculation(0.57);
    } else if (selectedJobNum == 5) {
      getBasicCalculation(0.55);
    } else if (selectedJobNum == 6) {
      getBasicCalculation(0.49);
    } else if(selectedJobNum == null) {
      getBasicCalculation(0.0);
    } else if(selectedJobNum == 6 || selectedJobNum >= 7) {
      getBasicCalculation(0.49);
    }
  }

  void sinkPremiumJobNumber(String jobNum) {
    _premiumJobNum.sink.add(jobNum);
    int selectedJobNum = int.tryParse(_premiumJobNum.value);
    if(selectedJobNum == 0) {
      getPremiumCalculation(0);
    } else if (selectedJobNum == 1) {
      getPremiumCalculation(1);
    } else if (selectedJobNum == 2) {
      getPremiumCalculation(0.75);
    } else if (selectedJobNum == 3) {
      getPremiumCalculation(0.59);
    } else if (selectedJobNum == 4) {
      getPremiumCalculation(0.57);
    } else if (selectedJobNum == 5) {
      getPremiumCalculation(0.55);
    } else if(selectedJobNum == null) {
      getPremiumCalculation(0.0);
    } else if(selectedJobNum == 6 || selectedJobNum >= 7) {
      getPremiumCalculation(0.49);
    }
  }

  Function(String) get sinkBasicJobFee => _basicJobFee.sink.add;

  Function(String) get sinkPremiumJobFee => _premiumJobFee.sink.add;

  Function(String) get sinkVat => _vat.sink.add;

  Function(String) get sinkSubTotal => _subTotal.sink.add;

  Function(String) get sinkSubTotalPlusVat => _subTotalPlusVat.sink.add;

  //--------------------------------------------------------------------

  void incrementBasicJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum >= 0) {
      jobNum++;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void incrementPremiumJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(_premiumJobNum.value);
    if (jobNum >= 0) {
      jobNum++;
      sinkPremiumJobNumber(jobNum.toString());
    }
  }

  void decrementBasicJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void decrementPremiumJobNum() {
    int jobNum = 0;
    jobNum = int.tryParse(_premiumJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkPremiumJobNumber(jobNum.toString());
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
    print('HHHH $subTotal');
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
  }

  void clearAllData() {
    _basicJobNum.value = null;
    _basicJobFee.value = null;
    _premiumJobFee.value = null;
    _premiumJobNum.value = null;
    _subTotal.value = null;
    _subTotalPlusVat.value = null;
    _vat.value = null;
    jobNum = 0;
    calculatedBasicFee = 0;
    calculatedPremiumFee = 0;
    subTotal = 0;
    subTotalVat = 0;
    subTotalPlusVatAmount = 0;
  }
}
