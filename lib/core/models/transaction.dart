import 'package:warunkq_apps/core/models/detail_transaction.dart';

class Transaction {
  String orderId;
  String orderName;
  int totalPrice;
  int discountAmount;
  int discountTotal;
  String status;
  String cancelReason;
  String createdAt;
  List<DetailTransaction> detailOrder;

  Transaction({
    this.orderId,
    this.orderName,
    this.totalPrice,
    this.discountAmount,
    this.discountTotal,
    this.status,
    this.cancelReason,
    this.createdAt,
    this.detailOrder,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderName = json['order_name'];
    totalPrice = json['total_price'];
    discountAmount = json['discount_amount'];
    discountTotal = json['discount_total'];
    status = json['status'];
    cancelReason = json['cancel_reason'];
    createdAt = json['created_at'];
    if (json['detail_order'] != null) {
      detailOrder = new List<DetailTransaction>();
      json['detail_order'].forEach((v) {
        detailOrder.add(new DetailTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_name'] = this.orderName;
    data['total_price'] = this.totalPrice;
    data['discount_amount'] = this.discountAmount;
    data['discount_total'] = this.discountTotal;
    data['status'] = this.status;
    data['cancel_reason'] = this.cancelReason;
    data['created_at'] = this.createdAt;
    if (this.detailOrder != null) {
      data['detail_order'] = this.detailOrder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
