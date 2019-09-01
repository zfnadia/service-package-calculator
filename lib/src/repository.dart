import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/servicePackageModel.dart';

class Repository {
  ServicePackageModel _servicePackageModel;

  Future<void> loadDataFromAsset() async {
    var jsonString =
        await rootBundle.loadString('assets/service_package_data.json');
    var jsonResponse = json.decode(jsonString);
    _servicePackageModel = ServicePackageModel.fromJson(jsonResponse);
  }

  ServicePackageModel get servicePackageModel => _servicePackageModel;
}

final repository = Repository();
