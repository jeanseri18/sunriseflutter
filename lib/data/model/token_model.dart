class AccessToken {
  String? accesstoken;
  String? expiresin;

  AccessToken({this.accesstoken = '', this.expiresin = ''});

  AccessToken.fromJson(Map<String, dynamic> json) {
    accesstoken = json['access_token'] ?? '';
    expiresin = json['expires_in'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accesstoken;
    data['expires_in'] = this.expiresin;
    return data;
  }
}
