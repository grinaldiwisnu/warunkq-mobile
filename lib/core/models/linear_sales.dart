class LinearSales {
  DateTime? days;
  int? sales;

  LinearSales(this.days, this.sales);

  LinearSales.fromJson(Map<String, dynamic> json) {
    days = DateTime.tryParse(json["date"]);
    sales = json["total"];
  }
}