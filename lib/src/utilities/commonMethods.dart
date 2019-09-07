import 'package:service_package_calculator/src/model/servicePackageModel.dart';

class CommonMethods {
  static Rate getServicePackageRate(
      String month, int selectedJobNum, List<Rate> rates) {
    Rate rate;
    if (selectedJobNum == null) {
      selectedJobNum = 0;
    }

    for (final value in rates) {
      if (selectedJobNum == value.max && month == value.duration.toString()) {
        rate = value;
        break;
      }
      if (selectedJobNum == value.min && month == value.duration.toString()) {
        rate = value;
        break;
      }
      if (selectedJobNum <= value.max &&
          selectedJobNum >= value.min &&
          selectedJobNum != 20 &&
          selectedJobNum != 30) {
        if (value.duration.toString() == month) {
          rate = value;
          break;
        }
      }
    }
    return rate;
  }

  static Rate getServicePackageRateWithoutMonth(
      int selectedJobNum, List<Rate> rates) {
    Rate rate;

    if (selectedJobNum == null) {
      selectedJobNum = 0;
    }
    for (final value in rates) {
      if (selectedJobNum == value.max) {
        rate = value;
      }
      if (selectedJobNum == value.min) {
        rate = value;
        break;
      }
      if (selectedJobNum <= value.max &&
          selectedJobNum >= value.min &&
          selectedJobNum != 20 &&
          selectedJobNum != 30) {
        rate = value;
        break;
      }
    }
    return rate;
  }
}
