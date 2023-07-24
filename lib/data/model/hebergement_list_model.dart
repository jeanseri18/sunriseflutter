class HebergementModel {
  String? status;
  List<Data>? data;

  HebergementModel({this.status, this.data});

  HebergementModel.fromJson(Map<String, dynamic> json) {
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
  List<Images>? images;
  List<Commodite>? commodite;
  User? user;

  Data(
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
      this.updatedAt,
      this.images,
      this.commodite,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['commodite'] != null) {
      commodite = <Commodite>[];
      json['commodite'].forEach((v) {
        commodite!.add(new Commodite.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.commodite != null) {
      data['commodite'] = this.commodite!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Images {
  int? id;
  String? fileUrl;
  String? typeFile;
  int? idUser;
  int? idHebergement;
  int? status;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
      this.fileUrl,
      this.typeFile,
      this.idUser,
      this.idHebergement,
      this.status,
      this.createdAt,
      this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileUrl = json['file_url'];
    typeFile = json['type_file'];
    idUser = json['id_user'];
    idHebergement = json['id_hebergement'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_url'] = this.fileUrl;
    data['type_file'] = this.typeFile;
    data['id_user'] = this.idUser;
    data['id_hebergement'] = this.idHebergement;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Commodite {
  int? id;
  int? wifi;
  int? parking;
  int? tv;
  int? frigo;
  int? clim;
  int? gardien;
  String? idHebergement;
  String? createdAt;
  String? updatedAt;

  Commodite(
      {this.id,
      this.wifi,
      this.parking,
      this.tv,
      this.frigo,
      this.clim,
      this.gardien,
      this.idHebergement,
      this.createdAt,
      this.updatedAt});

  Commodite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wifi = json['wifi'];
    parking = json['parking'];
    tv = json['tv'];
    frigo = json['frigo'];
    clim = json['clim'];
    gardien = json['gardien'];
    idHebergement = json['id_hebergement'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wifi'] = this.wifi;
    data['parking'] = this.parking;
    data['tv'] = this.tv;
    data['frigo'] = this.frigo;
    data['clim'] = this.clim;
    data['gardien'] = this.gardien;
    data['id_hebergement'] = this.idHebergement;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
