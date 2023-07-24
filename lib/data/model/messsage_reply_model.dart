class MessageReplyModel {
  String? status;
  Data? data;

  MessageReplyModel({this.status, this.data});

  MessageReplyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? idMessageList;
  int? idUserSend;
  String? message;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.idMessageList,
      this.idUserSend,
      this.message,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    idMessageList = json['id_message_list'];
    idUserSend = json['id_user_send'];
    message = json['message'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_message_list'] = this.idMessageList;
    data['id_user_send'] = this.idUserSend;
    data['message'] = this.message;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
