class ReservationPostModel {
  String? status;
  String? message;
  Data? data;

  ReservationPostModel({this.status, this.message, this.data});

  ReservationPostModel.fromJson(Map<String, dynamic> json) {
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
  String? idHebergement;
  String? idUser;
  String? idProprio;
  String? dateDebut;
  String? dateFin;
  String? montant;
  String? avance;
  String? reste;
  String? nbrePersonne;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.idHebergement,
      this.idUser,
      this.idProprio,
      this.dateDebut,
      this.dateFin,
      this.montant,
      this.avance,
      this.reste,
      this.nbrePersonne,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    idHebergement = json['id_hebergement'];
    idUser = json['id_user'];
    idProprio = json['id_proprio'];
    dateDebut = json['date_debut'];
    dateFin = json['date_fin'];
    montant = json['montant'];
    avance = json['avance'];
    reste = json['reste'];
    nbrePersonne = json['nbre_personne'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_hebergement'] = this.idHebergement;
    data['id_user'] = this.idUser;
    data['id_proprio'] = this.idProprio;
    data['date_debut'] = this.dateDebut;
    data['date_fin'] = this.dateFin;
    data['montant'] = this.montant;
    data['avance'] = this.avance;
    data['reste'] = this.reste;
    data['nbre_personne'] = this.nbrePersonne;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
