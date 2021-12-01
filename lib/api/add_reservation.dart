import 'dart:convert';

ReservationModel reservationModelFromJson(String str) => ReservationModel.fromJson(json.decode(str));

String reservationModelToJson(ReservationModel data) => json.encode(data.toJson());

class ReservationModel {
  int code = 0;
  String error_message;
  List data;

  ReservationModel({
    this.code,
    this.data,
    this.error_message,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) => ReservationModel(
        code: json["code"],
        data: json["data"] == null ? null : json["data"],
      error_message: json["error_message"] == null ? null : json["error_message"]
      );

  Map<String, dynamic> toJson() =>
      {
        "code": code,
        "data": data == null ? null : data,
        "error_message": error_message == null ? null : error_message,
      };
}
