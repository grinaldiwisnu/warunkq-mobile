class CartCashier {
  int usersId;
  int totalPrice;
  int status;
  List<DetailOrder> detailOrder;

  CartCashier({this.usersId, this.totalPrice, this.status, this.detailOrder});

  CartCashier.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    totalPrice = json['total_price'];
    status = json['status'];
    if (json['detail_order'] != null) {
      detailOrder = new List<DetailOrder>();
      json['detail_order'].forEach((v) {
        detailOrder.add(new DetailOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    if (this.detailOrder != null) {
      data['detail_order'] = this.detailOrder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailOrder {
  int prodId;
  int quantity;
  int subTotal;

  DetailOrder({this.prodId, this.quantity, this.subTotal});

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
