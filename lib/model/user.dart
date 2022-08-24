// ignore_for_file: unnecessary_null_comparison

class User {
  String? type;
  String? message;
  Data? data;

  User({type, message, data});

  User.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (data != null) {
      data['data'] =this. data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  String? role;
  int? userPoints;
  List<UserNotification>? userNotification;

  Data(
      {userId,
      firstName,
      lastName,
      email,
      imageUrl,
      address,
      role,
      userPoints,
      userNotification});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    role = json['role'];
    userPoints = json['UserPoints'];
     if (json['UserNotification'] != null) {
      userNotification = <UserNotification>[];
      json['UserNotification'].forEach((v) {
        userNotification!.add(UserNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    data['role'] = role;
    data['UserPoints'] = userPoints;
     if (userNotification != null) {
      data['UserNotification'] =
          userNotification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class UserNotification {
  String? notificationId;
  String? userId;
  String? imageUrl;
  String? message;
  String? createdAt;

  UserNotification(
      {this.notificationId,
        this.userId,
        this.imageUrl,
        this.message,
        this.createdAt});

  UserNotification.fromJson(Map<String, dynamic> json) {
    notificationId = json['notificationId'];
    userId = json['userId'];
    imageUrl = json['imageUrl'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notificationId'] = notificationId;
    data['userId'] = userId;
    data['imageUrl'] = imageUrl;
    data['message'] = message;
    data['createdAt'] = createdAt;
    return data;
  }
}
