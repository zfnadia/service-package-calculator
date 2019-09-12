import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:rxdart/rxdart.dart';
import '../repository.dart';
import 'package:intl/intl.dart';

class StandoutJobBloc extends BlocBase {
  //to get comma separated currency value
  final oCcy = NumberFormat("#,##0.00", "en_US");
  int jobNum = 0;
  int calculatedBasicFee = 0;
  int calculatedPremiumFee = 0;
  int subTotal = 0;
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

  Stream<String> get getBasicJobNum => _basicJobNum.stream;

  Stream<String> get getPremiumJobNum => _premiumJobNum.stream;

  Stream<String> get getBasicJobFee => _basicJobFee.stream;

  Stream<String> get getPremiumJobFee => _premiumJobFee.stream;

  Stream<String> get getVat => _vat.stream;

  Stream<String> get getSubTotal => _subTotal.stream;

  Stream<String> get getSubTotalPlusVat => _subTotalPlusVat.stream;

  //-----------------------Function---------------------------------------------

  void sinkBasicJobNumber(String jobNum, int index) {
    _basicJobNum.sink.add(jobNum);
    getBasicCalculation();
  }

  void sinkPremiumJobNumber(String jobNum, int index) {
    _premiumJobNum.sink.add(jobNum);
    getPremiumCalculation();
  }

  Function(String) get sinkBasicJobFee => _basicJobFee.sink.add;

  Function(String) get sinkPremiumJobFee => _premiumJobFee.sink.add;

  Function(String) get sinkVat => _vat.sink.add;

  Function(String) get sinkSubTotal => _subTotal.sink.add;

  Function(String) get sinkSubTotalPlusVat => _subTotalPlusVat.sink.add;

  //--------------------------------------------------------------------

  void incrementBasicJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(
        _basicJobNum.value == null || _basicJobNum.value.isEmpty
            ? '0'
            : _basicJobNum.value);
    if (jobNum >= 0 && jobNum < 9999) {
      jobNum++;
      sinkBasicJobNumber(jobNum.toString(), index);
    }
  }

  void incrementPremiumJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(
        _premiumJobNum.value == null || _premiumJobNum.value.isEmpty
            ? '0'
            : _premiumJobNum.value);
    if (jobNum >= 0 && jobNum < 9999) {
      jobNum++;
      sinkPremiumJobNumber(jobNum.toString(), index);
    }
  }

  void decrementBasicJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(
        _basicJobNum.value == null || _basicJobNum.value.isEmpty
            ? '0'
            : _basicJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkBasicJobNumber(jobNum.toString(), index);
    }
  }

  void decrementPremiumJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(
        _premiumJobNum.value == null || _premiumJobNum.value.isEmpty
            ? '0'
            : _premiumJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkPremiumJobNumber(jobNum.toString(), index);
    }
  }

  void getBasicCalculation() async {
    var servicePackageModel = await repository.getServicePackageModel();
    int basicRate = servicePackageModel.jobListing.standOut.normalRate;
    int jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum == null) {
      jobNum = 0;
    }
    calculatedBasicFee = (jobNum * basicRate);
    sinkBasicJobFee(oCcy.format(calculatedBasicFee).toString());
    calculateSubTotal();
    calculateVat();
    calculateSubTotalPlusVat();
  }

  void getPremiumCalculation() async {
    var servicePackageModel = await repository.getServicePackageModel();
    int premiumRate = servicePackageModel.jobListing.standOut.premiumRate;
    int jobNum = int.tryParse(_premiumJobNum.value);
    if (jobNum == null) {
      jobNum = 0;
    }

    calculatedPremiumFee = (jobNum * premiumRate);
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
