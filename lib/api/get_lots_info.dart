import 'dart:convert';

GetLotsInfoModel getlotsInfoModelFromJson(String str) => GetLotsInfoModel.fromJson(json.decode(str));

String getlotsInfoModelToJson(GetLotsInfoModel data) => json.encode(data.toJson());

class GetLotsInfoModel {
  int code = 0;
  List data;

  GetLotsInfoModel({
    this.code,
    this.data,
  });

  factory GetLotsInfoModel.fromJson(Map<String, dynamic> json) => GetLotsInfoModel(
        code: json["code"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() =>
      {
        "code": code,
        "data": data == null ? null : data,
      };
}
