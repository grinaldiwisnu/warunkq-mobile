import 'package:warunkq_apps/core/models/product.dart';

class DetailOrder {
  int prodId;
  int quantity;
  int subTotal;
  Product product;

  DetailOrder({this.prodId, this.quantity, this.subTotal, this.product});

  DetailOrder.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_id'];
    quantity = json['quantity'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prod_id'] = this.prodId;
    data['quantity'] = this.quantity;
    data['sub_total'] = this.subTotal;
    return data;
  }
}