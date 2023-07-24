class ReservationListModel {
  String? status;
  List<Data>? data;

  ReservationListModel({this.status, this.data});

  ReservationListModel.fromJson(Map<String, dynamic> json) {
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
  bool? isOwner;
  Hebergement? hebergement;
  UserPropio? userPropio;
  UserPropio? user;

  Data(
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
      this.updatedAt,
      this.isOwner,
      this.hebergement,
      this.userPropio,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
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
    isOwner = json['is_owner'];
    hebergement = json['hebergement'] != null
        ? new Hebergement.fromJson(json['hebergement'])
        : null;
    userPropio = json['user_propio'] != null
        ? new UserPropio.fromJson(json['user_propio'])
        : null;
    user = json['user'] != null ? new UserPropio.fromJson(json['user']) : null;
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
    data['is_owner'] = this.isOwner;
    if (this.hebergement != null) {
      data['hebergement'] = this.hebergement!.toJson();
    }
    if (this.userPropio != null) {
      data['user_propio'] = this.userPropio!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Hebergement {
  int? id;
  String? titre;
  String? typeLogement;
  String? categorie;
  String? ville;
  String? commune;
  String? description;
  String? adresse;
  int? idUser;
  String? dateDisponibilite;
  int? nbrePersonne;
  int? nbreLit;
  int? nbreSaleBain;
  int? prix;
  String? status;
  String? createdAt;
  String? updatedAt;

  Hebergement(
      {this.id,
      this.titre,
      this.typeLogement,
      this.categorie,
      this.ville,
      this.commune,
      this.description,
      this.adresse,
      this.idUser,
      this.dateDisponibilite,
      this.nbrePersonne,
      this.nbreLit,
      this.nbreSaleBain,
      this.prix,
      this.status,
      this.createdAt,
      this.updatedAt});

  Hebergement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titre = json['titre'];
    typeLogement = json['type_logement'];
    categorie = json['categorie'];
    ville = json['ville'];
    commune = json['commune'];
    description = json['description'];
    adresse = json['adresse'];
    idUser = json['id_user'];
    dateDisponibilite = json['date_disponibilite'];
    nbrePersonne = json['nbre_personne'];
    nbreLit = json['nbre_lit'];
    nbreSaleBain = json['nbre_sale_bain'];
    prix = json['prix'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titre'] = this.titre;
    data['type_logement'] = this.typeLogement;
    data['categorie'] = this.categorie;
    data['ville'] = this.ville;
    data['commune'] = this.commune;
    data['description'] = this.description;
    data['adresse'] = this.adresse;
    data['id_user'] = this.idUser;
    data['date_disponibilite'] = this.dateDisponibilite;
    data['nbre_personne'] = this.nbrePersonne;
    data['nbre_lit'] = this.nbreLit;
    data['nbre_sale_bain'] = this.nbreSaleBain;
    data['prix'] = this.prix;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserPropio {
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

  UserPropio(
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

  UserPropio.fromJson(Map<String, dynamic> json) {
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
