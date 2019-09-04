import 'package:service_package_calculator/src/model/servicePackageModel.dart';

import '../repository.dart';

class CommonMethods {
  static Rate getServicePackageRate(
      String month, int selectedJobNum, List<Rate> rates) {
    print('GOT VALUE month= $month selectedJobNum= $selectedJobNum');

    Rate rate;

    if (selectedJobNum == null) {
      selectedJobNum = 0;
    }

    for (final value in rates) {
      if (selectedJobNum == value.max && month == value.duration.toString()) {
        rate = value;
        print('GOT VALUE 21= ${value.rate}');
        break;
      }

      if (selectedJobNum == value.min && month == value.duration.toString()) {
        rate = value;
        print('GOT VALUE 22= ${value.rate}');
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
    print('GOT VALUE Final = ${rate.rate}');

    return rate;
  }
}
