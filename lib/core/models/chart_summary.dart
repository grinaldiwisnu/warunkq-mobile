import 'package:warunkq_apps/core/models/linear_sales.dart';

class ChartSummary {
  List<LinearSales>? data;
  Summary? summary;

  ChartSummary({this.data, this.summary});

  ChartSummary.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LinearSales>[];
      json['data'].forEach((v) {
        data!.add(new LinearSales.fromJson(v));
      });
    }
    if (json['summary'] != null) {
      summary = Summary.fromJson(json['summary'][0]);
    }
  }
}

class Summary {
  int? hpp;
  int? total;
  int? discount;
  int? products;

  Summary({this.hpp, this.total, this.discount, this.products});

  Summary.fromJson(Map<String, dynamic> json) {
    hpp = json['HPP'];
    total = json['TOTAL'];
    discount = json['DISCOUNT'];
    products = json['PRODUCT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HPP'] = this.hpp;
    data['TOTAL'] = this.total;
    data['DISCOUNT'] = this.discount;
    data['PRODUCT'] = this.products;
    return data;
  }
}
