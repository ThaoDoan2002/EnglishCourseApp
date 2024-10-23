
class BaseResponseEntity {
  String? data;

  BaseResponseEntity({
    this.data,
  });

  factory BaseResponseEntity.fromJson(Map<String, dynamic> json) =>
      BaseResponseEntity(
        data: json["checkout_url"],
      );

  Map<String, dynamic> toJson() => {
    "items": data,
  };
}

class BindFcmTokenRequestEntity {
  String? fcmtoken;

  BindFcmTokenRequestEntity({
    this.fcmtoken,
  });

  Map<String, dynamic> toJson() => {
    "fcmtoken": fcmtoken,
  };
}