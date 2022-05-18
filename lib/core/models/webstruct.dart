class Webstruct {
  bool? status;
  List<String>? target;
  String? message;
  String? process;
  List<int>? dataid;

  Webstruct(
      {this.status, this.target, this.message, this.process, this.dataid});

  Webstruct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    target = json['target'].cast<String>();
    message = json['message'];
    process = json['process'];
    dataid = json['dataid'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['target'] = this.target;
    data['message'] = this.message;
    data['process'] = this.process;
    data['dataid'] = this.dataid;
    return data;
  }
}
