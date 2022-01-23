class User {
  int? id;
  String? fullname,
      username,
      email,
      createdAt,
      updatedAt,
      phoneNumber,
      storeName,
      storeAddress,
      token;

  User(
      {this.id,
      this.fullname,
      this.username,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.phoneNumber,
      this.storeName,
      this.storeAddress,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phoneNumber = json['phone_number'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    token = json['token'];
    id = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phone_number'] = this.phoneNumber;
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    return data;
  }
}
