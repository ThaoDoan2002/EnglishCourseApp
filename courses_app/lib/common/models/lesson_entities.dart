import 'package:cloud_firestore/cloud_firestore.dart';

class LessonRequestEntity {
  int? id;

  LessonRequestEntity({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class LessonListResponseEntity {
  List<LessonItem>? data;

  LessonListResponseEntity({
    this.data,
  });

  factory LessonListResponseEntity.fromJson(List<dynamic> json) =>
      LessonListResponseEntity(
        data: json.isEmpty
            ? []
            : List<LessonItem>.from(json.map((x) => LessonItem.fromJson(x))),
      );
}

//api post response msg
class LessonDetailResponseEntity {
  List<LessonVideoItem>? data;

  LessonDetailResponseEntity({
    this.data,
  });

  factory LessonDetailResponseEntity.fromJson(List<dynamic> json) =>
      LessonDetailResponseEntity(
        data: json.isEmpty
            ? []
            : List<LessonVideoItem>.from(
                json.map((x) => LessonVideoItem.fromJson(x))),
      );
}

// login result
class LessonItem {
  String? subject;
  String? description;
  String? thumbnail;
  bool? status;
  int? id;

  LessonItem({
    this.subject,
    this.description,
    this.thumbnail,
    this.id,
    this.status,
  });

  factory LessonItem.fromJson(Map<String, dynamic> json) => LessonItem(
      subject: json["subject"],
      description: json["description"],
      thumbnail: json["thumbnail"],
      id: json["id"],
      status: json["payment_status"]);

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "description": description,
        "thumbnail": thumbnail,
        "id": id,
        "payment_status": status
      };
}

class LessonVideoItem {
  String? name;
  String? url;
  String? thumbnail;

  LessonVideoItem({
    this.name,
    this.url,
    this.thumbnail,
  });

  factory LessonVideoItem.fromJson(Map<String, dynamic> json) =>
      LessonVideoItem(
        name: json["name"],
        url: json["url"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "thumbnail": thumbnail,
      };
}

class LessonVideo {
  final List<LessonVideoItem> lessonItem;
  final Future<void>? initializeVideoPlayer;
  final bool isPlay;
  final String? url;

  LessonVideo(
      {this.lessonItem = const <LessonVideoItem>[],
      this.initializeVideoPlayer,
      this.isPlay = false,
      this.url = ""});

  LessonVideo copyWith(
      {List<LessonVideoItem>? lessonItem,
      Future<void>? initializeVideoPlayer,
      bool? isPlay,
      String? url}) {
    return LessonVideo(
        lessonItem: lessonItem ?? this.lessonItem,
        initializeVideoPlayer:
            initializeVideoPlayer ?? this.initializeVideoPlayer,
        isPlay: isPlay ?? this.isPlay,
        url: url ?? this.url);
  }
}
