import 'dart:convert';

LotsAddModel lotsAddModelFromJson(String str) => LotsAddModel.fromJson(json.decode(str));

String lotsAddModelToJson(LotsAddModel data) => json.encode(data.toJson());

class LotsAddModel {
  int code = 0;
  List data;

  LotsAddModel({
    this.code,
    this.data,
  });

  factory LotsAddModel.fromJson(Map<String, dynamic> json) => LotsAddModel(
        code: json["code"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() =>
      {
        "code": code,
        "data": data == null ? null : data,
      };
}
