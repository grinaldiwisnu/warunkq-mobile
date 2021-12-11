class Category {
  int id;
  String name;
  String description;
  String createdAt;
  String updatedAt;
  int usersId;

  Category(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.usersId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    usersId = json['users_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['users_id'] = this.usersId;
    return data;
  }
}
