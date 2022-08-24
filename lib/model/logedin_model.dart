class Autogenerated {
  String? type;
  String? message;
  Data? data;

  Autogenerated({this.type, this.message, this.data});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UserLogIn? user;
  String? accessToken;
  String? refreshToken;

  Data({this.user, this.accessToken, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ?  UserLogIn.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class UserLogIn {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;

  UserLogIn(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.imageUrl,
      });

  UserLogIn.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    return data;
  }
}