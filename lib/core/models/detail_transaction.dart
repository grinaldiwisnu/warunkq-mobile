class DetailTransaction {
  int? productsId, quantity, subTotal;
  String? name;

  DetailTransaction({this.productsId, this.quantity, this.subTotal, this.name});

  DetailTransaction.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    quantity = json['quantity'];
    subTotal = json['sub_total'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_id'] = this.productsId;
    data['quantity'] = this.quantity;
    data['sub_total'] = this.subTotal;
    data['name'] = this.name;
    return data;
  }
}
