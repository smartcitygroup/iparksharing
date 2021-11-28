import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int code;
  String error_message;

  LoginModel({this.code, this.error_message});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(code: json["code"], error_message: json["error_message"]);

  Map<String, dynamic> toJson() =>
      {"code": code, "error_message": error_message};
}

