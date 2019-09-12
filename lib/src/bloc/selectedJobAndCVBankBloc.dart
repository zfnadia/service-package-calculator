import 'package:rxdart/rxdart.dart';
import 'package:service_package_calculator/src/bloc/provider/blocProvider.dart';
import 'package:service_package_calculator/src/repository.dart';
import 'package:service_package_calculator/src/utilities/commonMethods.dart';
import 'package:service_package_calculator/src/utilities/constants.dart';

class SelectedJobAndCVBankBloc extends BlocBase {
  //-------------------BehaviorSubjects-----------------------------------------

  final _selectedJobNum = BehaviorSubject<String>();
  final _selectedJobFee = BehaviorSubject<String>();
  final _vat = BehaviorSubject<String>();
  final _subTotal = BehaviorSubject<String>();
  final _subTotalPlusVat = BehaviorSubject<String>();
  final _showDiscountForBasic = BehaviorSubject<String>();
  final _cvNum = BehaviorSubject<String>();
  final _cvFee = BehaviorSubject<String>();
  final _validity = BehaviorSubject<List<int>>();
  final _selectedMonth = BehaviorSubject<String>();
  final _cvStatus = BehaviorSubject<bool>();

  //-----------------------Stream-----------------------------------------------

  Stream<String> get getSelectedJobNum => _selectedJobNum.stream;

  Stream<String> get getSelectedJobFee => _selectedJobFee.stream;

  Stream<String> get getVat => _vat.stream;

  Stream<String> get getSubTotal => _subTotal.stream;

  Stream<String> get getSubTotalPlusVat => _subTotalPlusVat.stream;

  Stream<String> get showDiscountForBasic => _showDiscountForBasic.stream;

  Stream<String> get cvNum => _cvNum.stream;

  Stream<String> get cvFee => _cvFee.stream;

  Stream<List<int>> get getValidity => _validity.stream;

  Stream<String> get getSelectedMonth => _selectedMonth.stream;

  Stream<bool> get getCvStatus => _cvStatus.stream;

  //-----------------------Function---------------------------------------------

  void sinkSelectedJobNumber(String jobNum, int index) async {
    _selectedJobNum.sink.add(jobNum);
    int selectedJobNum = int.tryParse(_selectedJobNum.value);
    print("SELECTED JOB NUM $selectedJobNum");
    if (selectedJobNum == null) {
      sinkValidity(Constants.empty);
      sinkSelectedMonth('0', index);
    } else if (selectedJobNum >= 0 && selectedJobNum < 5) {
      sinkValidity(Constants.empty);
      sinkSelectedMonth('0', index);
    } else if (selectedJobNum < 20) {
      sinkValidity(Constants.sixMonth);
      sinkSelectedMonth('6', index);
    } else if (selectedJobNum == 20) {
      sinkSelectedMonth('9', index);
      sinkValidity(Constants.sixNineMonths);

    } else if (selectedJobNum > 20 && selectedJobNum < 30) {
      sinkValidity(Constants.nineMonth);
      sinkSelectedMonth('9', index);
    } else if (selectedJobNum == 30) {
      sinkValidity(Constants.nineTwelveMonths);
      sinkSelectedMonth('12', index);
    } else if (selectedJobNum > 30) {
      sinkValidity(Constants.twelveMonth);
      sinkSelectedMonth('12', index);
    }
  }

  void sinkSelectedMonth(String month, int index) {
    print("SELECTED MONTH $month");
    _selectedMonth.sink.add(month);
    int selectedJobNum = int.tryParse(_selectedJobNum.value);
    getMonthAndJobNumCalculation(_selectedMonth.value, selectedJobNum, index);
  }

  void sinkCVStatus(bool status, int index) {
    _cvStatus.sink.add(status);
    int selectedJobNum = int.tryParse(_selectedJobNum.value);
    getMonthAndJobNumCalculation(_selectedMonth.value, selectedJobNum, index);
  }

  Function(String) get sinkSelectedJobFee => _selectedJobFee.sink.add;

  Function(String) get sinkVat => _vat.sink.add;

  Function(String) get sinkSubTotal => _subTotal.sink.add;

  Function(String) get sinkSubTotalPlusVat => _subTotalPlusVat.sink.add;

  Function(String) get sinkShowDiscountBasic => _showDiscountForBasic.sink.add;

  Function(String) get sinkCVNum => _cvNum.sink.add;

  Function(String) get sinkCVFee => _cvFee.sink.add;

  Function(List<int>) get sinkValidity => _validity.sink.add;

  //--------------------------------------------------------------------

  void incrementSelectedJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(
        _selectedJobNum.value == null || _selectedJobNum.value.isEmpty
            ? '0'
            : _selectedJobNum.value);
    if (jobNum >= 0 ) {
      jobNum++;
      sinkSelectedJobNumber(jobNum.toString(), index);
    }
  }

  void decrementSelectedJobNum(int index) {
    int jobNum = 0;
    jobNum = int.tryParse(
        _selectedJobNum.value == null || _selectedJobNum.value.isEmpty
            ? '0'
            : _selectedJobNum.value);
    if (jobNum > 0) {
      jobNum--;
      sinkSelectedJobNumber(jobNum.toString(), index);
    }
  }

  void getMonthAndJobNumCalculation(
      String month, int selectedJobNum, int index) async {
    var servicePackageModel = await repository.getServicePackageModel();

    if (selectedJobNum == null) {
      selectedJobNum = 0;
    }

    var servicePackage = CommonMethods.getServicePackageRate(month,
        selectedJobNum, servicePackageModel.jobListing.bulk[index].rates);

    int vat = servicePackageModel.vat;
    int basicRate = servicePackage.rate;
    int discount = servicePackage.discount;
    int cvNum = servicePackage.cv;
    int cvFee = servicePackage.cvFee;
    int calculatedBasicFee = (selectedJobNum * basicRate);
    int subTotal = calculatedBasicFee + (_cvStatus.value == false ? 0 : cvFee);
    double subTotalVat = subTotal * (vat / 100);
    double subTotalPlusVat = subTotal + subTotalVat;
    sinkSelectedJobFee(Constants.oCcy.format(calculatedBasicFee).toString());
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
    _selectedJobNum.close();
    _selectedJobFee.close();
    _subTotal.close();
    _subTotalPlusVat.close();
    _vat.close();
    _showDiscountForBasic.close();
    _cvNum.close();
    _cvFee.close();
    _validity.close();
    _selectedMonth.close();
    _cvStatus.close();
  }

  void clearAllData() {
    _selectedJobNum.value = null;
    _selectedJobFee.value = null;
    _subTotal.value = '0.0';
    _subTotalPlusVat.value = '0.0';
    _vat.value = null;
    _showDiscountForBasic.value = null;
    _cvNum.value = null;
    _cvFee.value = null;
    _validity.value = null;
    _selectedMonth.value = '0';
    _cvStatus.value = null;
  }
}
