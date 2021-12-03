class Product {
  int id;
  String productName;
  String description;
  String image;
  String category;
  int price;
  int quantity;
  String createdAt;
  String updatedAt;

  Product(
      {this.id,
      this.productName,
      this.description,
      this.image,
      this.category,
      this.price,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
    price = json['price'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category'] = this.category;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
