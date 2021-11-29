import 'dart:convert';

LotsAddModel lotsAddModelFromJson(String str) => LotsAddModel.fromJson(json.decode(str));

String lotsAddModelToJson(LotsAddModel data) => json.encode(data.toJson());

class LotsAddModel {
  int code = 0;

  LotsAddModel({
    this.code,
  });

  factory LotsAddModel.fromJson(Map<String, dynamic> json) => LotsAddModel(
        code: json["code"],
      );

  Map<String, dynamic> toJson() =>
      {
        "code": code,
      };
}
