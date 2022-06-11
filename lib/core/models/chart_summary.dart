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
  int? hpp = 0;
  int? total = 0;
  int? discount = 0;
  int? products = 0;

  Summary({this.hpp, this.total, this.discount, this.products});

  Summary.fromJson(Map<String, dynamic> json) {
    hpp = json['HPP'] ?? 0;
    total = json['TOTAL'] ?? 0;
    discount = json['DISCOUNT'] ?? 0;
    products = json['PRODUCT'] ?? 0;
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
