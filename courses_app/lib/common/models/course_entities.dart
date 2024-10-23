import 'package:cloud_firestore/cloud_firestore.dart';

class CourseRequestEntity {
  int? id;

  CourseRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class SearchRequestEntity {
  String? search;

  SearchRequestEntity({
    this.search,
  });

  Map<String, dynamic> toJson() => {
        "search": search,
      };
}

class CourseListResponseEntity {
  int? count;
  String? next;
  String? previous;
  List<CourseItem>? results;

  CourseListResponseEntity(
      {this.count, this.next, this.previous, this.results});

  factory CourseListResponseEntity.fromJson(Map<String, dynamic> json) =>
      CourseListResponseEntity(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<CourseItem>.from(
                json["results"].map((x) => CourseItem.fromJson(x))),
      );
}

//api post response msg
class CourseDetailResponseEntity {
  CourseItem? data;

  CourseDetailResponseEntity({
    this.data,
  });

  factory CourseDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      CourseDetailResponseEntity(
        data: CourseItem.fromJson(json),
      );
}

class AuthorRequestEntity {
  String? token;

  AuthorRequestEntity({
    this.token,
  });

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

//api post response msg
class AuthorResponseEntity {
  int? code;
  String? msg;
  AuthorItem? data;

  AuthorResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory AuthorResponseEntity.fromJson(Map<String, dynamic> json) =>
      AuthorResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: AuthorItem.fromJson(json["data"]),
      );
}

// login result
class AuthorItem {
  String? token;
  String? name;
  String? description;
  String? avatar;
  String? job;
  int? follow;
  int? score;
  int? download;
  int? online;

  AuthorItem({
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.job,
    this.follow,
    this.score,
    this.download,
    this.online,
  });

  factory AuthorItem.fromJson(Map<String, dynamic> json) => AuthorItem(
        token: json["token"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        job: json["job"],
        follow: json["follow"],
        score: json["score"],
        download: json["download"],
        online: json["online"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "description": description,
        "avatar": avatar,
        "job": job,
        "follow": follow,
        "score": score,
        "download": download,
        "online": online,
      };
}

// login result
class CourseItem {
  String? name;
  String? description;
  String? thumbnail;
  int? price;
  int? id;
  bool? status;

  CourseItem(
      {this.name,
      this.description,
      this.thumbnail,
      this.price,
      this.id,
      this.status});

  factory CourseItem.fromJson(Map<String, dynamic> json) => CourseItem(
      name: json["name"],
      description: json["description"],
      thumbnail: json["thumbnail"],
      price: json["price"],
      id: json["id"],
      status: json["payment_status"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "price": price,
        "id": id,
        "payment_status": status
      };
}
