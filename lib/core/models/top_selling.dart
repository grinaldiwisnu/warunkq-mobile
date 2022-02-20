class TopSelling {
  int? productsId;
  String? name;
  int? selling;
  int? total;

  TopSelling({this.productsId, this.name, this.selling, this.total});

  TopSelling.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    name = json['name'];
    selling = json['selling'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_id'] = this.productsId;
    data['name'] = this.name;
    data['selling'] = this.selling;
    data['total'] = this.total;
    return data;
  }
}
