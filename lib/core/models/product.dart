import 'dart:io';

import 'package:dio/dio.dart';

class Product {
  int? id, quantity, price, basePrice, categoryId;
  String? createdAt, updatedAt, category, description, image, productName;
  File? uploadImage;

  Product(
      {this.id,
      this.productName,
      this.description,
      this.image,
      this.category,
      this.price,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.basePrice,
      this.categoryId,
      this.uploadImage});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
    categoryId = json['category_id'];
    basePrice = json['price'];
    price = json['sell_price'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prod_name'] = this.productName;
    data['prod_desc'] = this.description;
    data['prod_image'] = this.image;
    data['category'] = this.category;
    data['prod_sell_price'] = this.price;
    data['prod_quantity'] = this.quantity;
    data['prod_categories_id'] = this.categoryId;
    data['prod_price'] = this.basePrice;
    return data;
  }

  Future<Map<String, dynamic>> toMap() async {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'prod_name': this.productName,
      'prod_desc': this.description,
      'prod_image': uploadImage == null ? null : await MultipartFile.fromFile(
          this.uploadImage!.path, filename: this.uploadImage!.path.split('/').last
      ),
      'category': this.category,
      'prod_quantity': this.quantity,
      'prod_categories_id': this.categoryId,
      'prod_price': this.basePrice,
      'prod_sell_price': this.price,
    } as Map<String, dynamic>;
  }
}
