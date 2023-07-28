class AccessToken {
  String? accessToken;
  String? tokenType;
  String? expiresIn; // Modifier le type en String

  AccessToken({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  AccessToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'].toString(); // Convertir la valeur en String
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;

    return data;
  }
}
