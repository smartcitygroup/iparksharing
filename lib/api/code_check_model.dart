import 'dart:convert';

CodeCheckModel codeCheckModelFromJson(String str) =>
    CodeCheckModel.fromJson(json.decode(str));

String codeCheckModelToJson(CodeCheckModel data) => json.encode(data.toJson());

class CodeCheckModel {
  int code = 0;
  String error_message;
  int ID = 0;
  String token = "";

  CodeCheckModel({this.code, this.error_message, this.ID, this.token});

  factory CodeCheckModel.fromJson(Map<String, dynamic> json) => CodeCheckModel(
      code: json["code"],
      error_message: json["error_message"],
      ID: json["data"] == null ? null : json["data"]["ID"],
      token: json["data"] == null ? null : json["data"]["token"]);

  Map<String, dynamic> toJson() =>
      {
        "code": code,
        "error_message": error_message,
        "ID": ID == null ? null : ID,
        "token": token == null ? null : token
      };
}
