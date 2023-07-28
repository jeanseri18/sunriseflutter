class MessagePostModel {
  String? status;
  String? message;
  Data? data;

  MessagePostModel({this.status, this.message, this.data});

  MessagePostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? idUserCustomer;
  int? idUserProprio;
  String? date;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.idUserCustomer,
    this.idUserProprio,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUserCustomer = json['id_user_customer'];
    idUserProprio = json['id_user_proprio'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user_customer'] = this.idUserCustomer;
    data['id_user_proprio'] = this.idUserProprio;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
