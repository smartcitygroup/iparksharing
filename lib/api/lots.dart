import 'dart:convert';

LotsModel lotsModelFromJson(String str) => LotsModel.fromJson(json.decode(str));

String lotsModelToJson(LotsModel data) => json.encode(data.toJson());

class LotsModel {
  int code = 0;
  List data;

  LotsModel({
    this.code,
    this.data,
  });

  factory LotsModel.fromJson(Map<String, dynamic> json) => LotsModel(
        code: json["code"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() =>
      {
        "code": code,
        "data": data == null ? null : data,
      };
}
