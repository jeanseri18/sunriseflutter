class PaymentModel {
  String? status;
  List<Data>? data;

  PaymentModel({this.status, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  int? idTypePayment;
  int? idCommande;
  int? montant;
  String? date;
  int? idUser;
  String? status;
  String? createdAt;
  String? updatedAt;
  Reservation? reservation;

  Data(
      {this.id,
      this.idTypePayment,
      this.idCommande,
      this.montant,
      this.date,
      this.idUser,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.reservation});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTypePayment = json['id_type_payment'];
    idCommande = json['id_commande'];
    montant = json['montant'];
    date = json['date'];
    idUser = json['id_user'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reservation = json['reservation'] != null
        ? new Reservation.fromJson(json['reservation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_type_payment'] = this.idTypePayment;
    data['id_commande'] = this.idCommande;
    data['montant'] = this.montant;
    data['date'] = this.date;
    data['id_user'] = this.idUser;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.reservation != null) {
      data['reservation'] = this.reservation!.toJson();
    }
    return data;
  }
}

class Reservation {
  int? id;
  int? idHebergement;
  int? idUser;
  int? idProprio;
  String? dateDebut;
  String? dateFin;
  int? montant;
  int? avance;
  int? reste;
  int? nbrePersonne;
  String? status;
  String? createdAt;
  String? updatedAt;

  Reservation(
      {this.id,
      this.idHebergement,
      this.idUser,
      this.idProprio,
      this.dateDebut,
      this.dateFin,
      this.montant,
      this.avance,
      this.reste,
      this.nbrePersonne,
      this.status,
      this.createdAt,
      this.updatedAt});

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
