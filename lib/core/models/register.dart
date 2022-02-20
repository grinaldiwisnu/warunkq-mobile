class Register {
  String? fullname;
  String? email;
  String? username;
  String? password;
  String? phone;
  String? storeName;
  String? storeAddress;

  Register(
      {this.fullname,
        this.email,
        this.username,
        this.password,
        this.phone,
        this.storeName,
        this.storeAddress});

  Register.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    return data;
  }
}
