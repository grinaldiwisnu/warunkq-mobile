class Product {
  int id;
  String productName;
  String description;
  String image;
  String category;
  int categoryId;
  int basePrice;
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
      this.updatedAt,
      this.basePrice,
      this.categoryId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
    categoryId = json['category_id'];
    basePrice = json['base_price'];
    price = json['price'];
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
}
