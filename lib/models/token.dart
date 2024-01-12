class Token {
  String? accessToken;
  String? refreshToken;
  String? expiresIn;

  Token({this.accessToken, this.refreshToken, this.expiresIn});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['expiresIn'] = expiresIn;
    return data;
  }
}