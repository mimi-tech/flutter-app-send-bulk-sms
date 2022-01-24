import 'dart:convert';

UserError userErrorFromJson(String str) => UserError.fromJson(json.decode(str));

String userErrorToJson(UserError data) => json.encode(data.toJson());

class UserError {
  UserError({
    required this.code,
    required this.message,
  });

  int code;
  String message;

  factory UserError.fromJson(Map<String, dynamic> json) => UserError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}



UserSuccess userSuccessFromJson(String str) => UserSuccess.fromJson(json.decode(str));

String userSuccessToJson(UserError data) => json.encode(data.toJson());

class UserSuccess {
  UserSuccess({
    required this.code,
    required this.message,
    required this.data,
  });

  dynamic code;
  String message;
  String data;

  factory UserSuccess.fromJson(Map<String, dynamic> json) => UserSuccess(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data,
  };
}
