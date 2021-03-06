import 'package:warunkq_apps/core/models/detail_order.dart';

class CartCashier {
  int? usersId, customerId, discountAmount, discountTotal;
  int totalPrice, totalProduct;
  String? status = "success";
  String? orderNumber, orderName, phoneNumber;
  List<DetailOrder> detailOrder = <DetailOrder>[];

  CartCashier(
      {this.usersId,
      this.totalPrice = 0,
      this.totalProduct = 0,
      this.orderName,
      this.discountAmount,
      this.discountTotal,
      this.orderNumber});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.usersId;
    data['customer_id'] = this.customerId;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['order_id'] = this.orderNumber;
    data['order_name'] = this.orderName;
    data['discount_amount'] = this.discountAmount;
    data['discount_total'] = this.discountTotal;
    data['phone_number'] = this.phoneNumber;
    if (this.detailOrder != null) {
      data['detail_order'] = this.detailOrder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
