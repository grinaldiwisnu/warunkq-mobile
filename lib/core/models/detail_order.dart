import 'package:warunkq_apps/core/models/product.dart';

class DetailOrder {
  int? prodId;
  late int quantity, subTotal, productionPrice;
  Product? product;

  DetailOrder({this.prodId, this.quantity = 0, this.subTotal = 0, this.product, this.productionPrice = 0});

  DetailOrder.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    quantity = json['quantity'] != null ? json['quantity'] : 0;
    subTotal = json['sub_total'] != null ? json['sub_total'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prod_id'] = this.prodId;
    data['quantity'] = this.quantity;
    data['sub_total'] = this.subTotal;
    data['prod_price'] = this.productionPrice;
    return data;
  }
}