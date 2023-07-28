class PaymentPostModel {
  String? status;
  String? message;
  Data? data;

  PaymentPostModel({this.status, this.message, this.data});

  PaymentPostModel.fromJson(Map<String, dynamic> json) {
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
  String? idTypePayment;
  String? idCommande;
  String? montant;
  String? date;
  String? idUser;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.idTypePayment,
      this.idCommande,
      this.montant,
      this.date,
      this.idUser,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    idTypePayment = json['id_type_payment'];
    idCommande = json['id_commande'];
    montant = json['montant'];
    date = json['date'];
    idUser = json['id_user'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_type_payment'] = this.idTypePayment;
    data['id_commande'] = this.idCommande;
    data['montant'] = this.montant;
    data['date'] = this.date;
    data['id_user'] = this.idUser;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
