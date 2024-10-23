import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_app/common/utils/constants.dart';

class LoginRequestEntity {
  int? type;
  String? name;
  String? description;
  String? email;
  String? phone;
  String? avatar;
  String? open_id;
  int? online;

  LoginRequestEntity({
    this.type,
    this.name,
    this.description,
    this.email,
    this.phone,
    this.avatar,
    this.open_id,
    this.online,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "description": description,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "open_id": open_id,
        "online": online,
      };
}

//api post response msg
class UserLoginResponseEntity {
  int? code;
  String? msg;
  UserProfile? data;

  UserLoginResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: UserProfile.fromJson(json["data"]),
      );
}

// login result
class UserProfile {
  String? first_name;
  String? last_name;
  String? username;
  String? email;
  String? avatar;

  UserProfile({
    this.first_name,
    this.last_name,
    this.username,
    this.email,
    this.avatar =
        'https://res.cloudinary.com/dzrgeifj0/image/upload/v1726559796/default_vws2ql.png',
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      first_name: json["first_name"],
      last_name: json["last_name"],
      username: json["username"],
      email: json["email"],
      avatar: json["avatar"] != null && json["avatar"].isNotEmpty
          ? "${AppConstants.IMAGE_UPLOADS_PATH}${json["avatar"]}"
          : "https://res.cloudinary.com/dzrgeifj0/image/upload/v1726559796/default_vws2ql.png",
    );
  }

  Map<String, dynamic> toJson() => {
        "first_name": first_name,
        "last_name": last_name,
        "username": username,
        "email": email,
        "avatar": avatar,
      };
}

class UserData {
  final String? token;
  final String? name;
  final String? avatar;
  final String? description;
  final int? online;

  UserData({
    this.token,
    this.name,
    this.avatar,
    this.description,
    this.online,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      token: data?['token'],
      name: data?['name'],
      avatar: data?['avatar'],
      description: data?['description'],
      online: data?['online'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (token != null) "token": token,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (description != null) "description": description,
      if (online != null) "online": online,
    };
  }
}
