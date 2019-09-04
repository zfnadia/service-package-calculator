import 'package:service_package_calculator/src/model/servicePackageModel.dart';

import '../repository.dart';

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
          print('GOT VALUE 1 = ${value.rate}');
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
        print('GOT VALUE 11 = ${value.cv} rate = ${rate.rate}');
      }

      if (selectedJobNum == value.min ) {
        rate = value;
        print('GOT VALUE 22 = ${value.cv} rate = ${rate.rate}');
        break;
      }
      if (selectedJobNum <= value.max &&
          selectedJobNum >= value.min &&
          selectedJobNum != 20 &&
          selectedJobNum != 30) {

        rate = value;
        print('GOT VALUE 33 = ${value.cv} rate = ${rate.rate}');
        break;
      }
    }

    print('GOT VALUE 44 = ${rate.cv} rate = ${rate.rate}');
    return rate;
  }
}
