// To parse this JSON data, do
//
//     final servicePackageModel = servicePackageModelFromJson(jsonString);

import 'dart:convert';

ServicePackageModel servicePackageModelFromJson(String str) => ServicePackageModel.fromJson(json.decode(str));

String servicePackageModelToJson(ServicePackageModel data) => json.encode(data.toJson());

class ServicePackageModel {
  JobListing jobListing;
  int vat;

  ServicePackageModel({
    this.jobListing,
    this.vat,
  });

  factory ServicePackageModel.fromJson(Map<String, dynamic> json) => new ServicePackageModel(
    jobListing: JobListing.fromJson(json["job_listing"]),
    vat: json["vat"],
  );

  Map<String, dynamic> toJson() => {
    "job_listing": jobListing.toJson(),
    "vat": vat,
  };
}

class JobListing {
  Basic basic;
  StandOut standOut;
  HotJob hotJob;
  List<Bulk> bulk;

  JobListing({
    this.basic,
    this.standOut,
    this.hotJob,
    this.bulk,
  });

  factory JobListing.fromJson(Map<String, dynamic> json) => new JobListing(
    basic: Basic.fromJson(json["basic"]),
    standOut: StandOut.fromJson(json["stand_out"]),
    hotJob: HotJob.fromJson(json["hot_job"]),
    bulk: new List<Bulk>.from(json["bulk"].map((x) => Bulk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "basic": basic.toJson(),
    "stand_out": standOut.toJson(),
    "hot_job": hotJob.toJson(),
    "bulk": new List<dynamic>.from(bulk.map((x) => x.toJson())),
  };
}

class Basic {
  int rate;

  Basic({
    this.rate,
  });

  factory Basic.fromJson(Map<String, dynamic> json) => new Basic(
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
  };
}

class Bulk {
  String name;
  List<Rate> rates;

  Bulk({
    this.name,
    this.rates,
  });

  factory Bulk.fromJson(Map<String, dynamic> json) => new Bulk(
    name: json["name"],
    rates: new List<Rate>.from(json["rates"].map((x) => Rate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "rates": new List<dynamic>.from(rates.map((x) => x.toJson())),
  };
}

class Rate {
  int min;
  int max;
  int duration;
  int discount;
  int rate;
  int cv;
  int cvFee;

  Rate({
    this.min,
    this.max,
    this.duration,
    this.discount,
    this.rate,
    this.cv,
    this.cvFee,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => new Rate(
    min: json["min"],
    max: json["max"],
    duration: json["duration"],
    discount: json["discount"],
    rate: json["rate"],
    cv: json["cv"],
    cvFee: json["cv_fee"],
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
    "duration": duration,
    "discount": discount,
    "rate": rate,
    "cv": cv,
    "cv_fee": cvFee,
  };
}

class HotJob {
  int normalRate;
  int premiumRate;
  int discountForTwo;
  int discountForThree;
  int discountForFour;
  int discountForFive;
  int discountForSixAbove;

  HotJob({
    this.normalRate,
    this.premiumRate,
    this.discountForTwo,
    this.discountForThree,
    this.discountForFour,
    this.discountForFive,
    this.discountForSixAbove,
  });

  factory HotJob.fromJson(Map<String, dynamic> json) => new HotJob(
    normalRate: json["normal_rate"],
    premiumRate: json["premium_rate"],
    discountForTwo: json["discount_for_two"],
    discountForThree: json["discount_for_three"],
    discountForFour: json["discount_for_four"],
    discountForFive: json["discount_for_five"],
    discountForSixAbove: json["discount_for_six_above"],
  );

  Map<String, dynamic> toJson() => {
    "normal_rate": normalRate,
    "premium_rate": premiumRate,
    "discount_for_two": discountForTwo,
    "discount_for_three": discountForThree,
    "discount_for_four": discountForFour,
    "discount_for_five": discountForFive,
    "discount_for_six_above": discountForSixAbove,
  };
}

class StandOut {
  int normalRate;
  int premiumRate;

  StandOut({
    this.normalRate,
    this.premiumRate,
  });

  factory StandOut.fromJson(Map<String, dynamic> json) => new StandOut(
    normalRate: json["normal_rate"],
    premiumRate: json["premium_rate"],
  );

  Map<String, dynamic> toJson() => {
    "normal_rate": normalRate,
    "premium_rate": premiumRate,
  };
}
