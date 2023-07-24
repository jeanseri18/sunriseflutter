class MessageListModel {
  String? status;
  List<Data>? data;

  MessageListModel({this.status, this.data});

  MessageListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  Customer? customer;
  Customer? proprio;
  LatestMessage? latestMessage;
  Customer? latestMessageSender;

  Data(
      {this.id,
      this.idUserCustomer,
      this.idUserProprio,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.proprio,
      this.latestMessage,
      this.latestMessageSender});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUserCustomer = json['id_user_customer'];
    idUserProprio = json['id_user_proprio'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    proprio =
        json['proprio'] != null ? new Customer.fromJson(json['proprio']) : null;
    latestMessage = json['latest_message'] != null
        ? new LatestMessage.fromJson(json['latest_message'])
        : null;
    latestMessageSender = json['latest_message_sender'] != null
        ? new Customer.fromJson(json['latest_message_sender'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user_customer'] = this.idUserCustomer;
    data['id_user_proprio'] = this.idUserProprio;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.proprio != null) {
      data['proprio'] = this.proprio!.toJson();
    }
    if (this.latestMessage != null) {
      data['latest_message'] = this.latestMessage!.toJson();
    }
    if (this.latestMessageSender != null) {
      data['latest_message_sender'] = this.latestMessageSender!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? telephone;
  String? birthday;
  String? typeCompte;
  String? idPays;
  String? ville;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.name,
      this.telephone,
      this.birthday,
      this.typeCompte,
      this.idPays,
      this.ville,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    birthday = json['birthday'];
    typeCompte = json['type_compte'];
    idPays = json['id_pays'];
    ville = json['ville'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['telephone'] = this.telephone;
    data['birthday'] = this.birthday;
    data['type_compte'] = this.typeCompte;
    data['id_pays'] = this.idPays;
    data['ville'] = this.ville;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LatestMessage {
  int? id;
  int? idMessageList;
  int? idUserSend;
  String? message;
  String? status;
  String? createdAt;
  String? updatedAt;
  Customer? sender;

  LatestMessage(
      {this.id,
      this.idMessageList,
      this.idUserSend,
      this.message,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.sender});

  LatestMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMessageList = json['id_message_list'];
    idUserSend = json['id_user_send'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender =
        json['sender'] != null ? new Customer.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_message_list'] = this.idMessageList;
    data['id_user_send'] = this.idUserSend;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    return data;
  }
}
