import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/servicePackageModel.dart';

class Repository {
  ServicePackageModel _servicePackageModel;

  Future<ServicePackageModel> _loadDataFromAsset() async {
    var jsonString =
        await rootBundle.loadString('assets/service_package_data.json');
    var jsonResponse = json.decode(jsonString);
    _servicePackageModel = ServicePackageModel.fromJson(jsonResponse);
    return _servicePackageModel;
  }

  Future<ServicePackageModel>  getServicePackageModel ()async{
    return _servicePackageModel== null ? await _loadDataFromAsset():_servicePackageModel;
  }
}

final repository = Repository();
