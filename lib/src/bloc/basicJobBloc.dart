import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:rxdart/rxdart.dart';
import '../repository.dart';
import 'package:intl/intl.dart';

class BasicJobBloc extends BlocBase {
  //to get comma separated currency value
  final oCcy = NumberFormat("#,##0.00", "en_US");
  int jobNum = 0;

  //-------------------BehaviorSubjects-----------------------------------------
  final _basicJobNum = BehaviorSubject<String>();
  final _basicJobFee = BehaviorSubject<String>();
  final _vat = BehaviorSubject<String>();
  final _totalAmount = BehaviorSubject<String>();

  //-----------------------Stream-----------------------------------------------
  Stream<String> get basicJobNum => _basicJobNum.stream;

  Stream<String> get basicJobFee => _basicJobFee.stream;

  Stream<String> get jobVat => _vat.stream;

  Stream<String> get totalAmount => _totalAmount.stream;

  //-----------------------Function---------------------------------------------
  //Function(String) get sinkBasicJobNum => _basicJobNum.sink.add;
  Function(String) get sinkBasicJobFee => _basicJobFee.sink.add;

  Function(String) get sinkVat => _vat.sink.add;

  Function(String) get sinkTotalAmount => _totalAmount.sink.add;

  void sinkBasicJobNumber(String jobNum) {
    _basicJobNum.sink.add(jobNum);
    getBasicJobAmount();
  }

  void incrementJobNum() {
    int jobNum = 0;
    jobNum =
        int.tryParse(_basicJobNum.value == null ? '0' : _basicJobNum.value);
    if (jobNum >= 0) {
      jobNum++;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void decrementJobNum() {
    int jobNum = 0;
    jobNum =
        int.tryParse(_basicJobNum.value == null ? '0' : _basicJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkBasicJobNumber(jobNum.toString());
    }
  }

  void getBasicJobAmount() async {
    var servicePackageModel = await repository.getServicePackageModel();
    int basicRate = servicePackageModel.jobListing.basic.rate;
    int jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum == null) {
      jobNum = 0;
    }

    int calculatedAmount = (jobNum * basicRate);
    double vat = calculatedAmount * 0.05;
    double totalAmount = calculatedAmount + vat;
    sinkBasicJobFee(oCcy.format(calculatedAmount).toString());
    sinkVat(oCcy.format(vat).toString());
    sinkTotalAmount(oCcy.format(totalAmount).toString());
  }

  void getStandOutJobAmount() async {
    var servicePackageModel = await repository.getServicePackageModel();
    int basicRate = servicePackageModel.jobListing.standOut.normalRate;
    int jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum == null) {
      jobNum = 0;
    }

    int calculatedAmount = (jobNum * basicRate);
    double vat = calculatedAmount * 0.05;
    double totalAmount = calculatedAmount + vat;
    sinkBasicJobFee(oCcy.format(calculatedAmount).toString());
    sinkVat(oCcy.format(vat).toString());
    sinkTotalAmount(oCcy.format(totalAmount).toString());
  }

  void getStandOutPremiumJobAmount() async {
    var servicePackageModel = await repository.getServicePackageModel();
    int basicRate = servicePackageModel.jobListing.standOut.premiumRate;
    int jobNum = int.tryParse(_basicJobNum.value);
    if (jobNum == null) {
      jobNum = 0;
    }

    int calculatedAmount = (jobNum * basicRate);
    double vat = calculatedAmount * 0.05;
    double totalAmount = calculatedAmount + vat;
    sinkBasicJobFee(oCcy.format(calculatedAmount).toString());
    sinkVat(oCcy.format(vat).toString());
    sinkTotalAmount(oCcy.format(totalAmount).toString());
  }

  @override
  void dispose() {
    _basicJobNum.close();
    _basicJobFee.close();
    _totalAmount.close();
    _vat.close();
  }

  void clearAllData() {
    _basicJobNum.value = null;
    _basicJobFee.value = null;
    _vat.value = null;
    _totalAmount.value = null;
  }
}
