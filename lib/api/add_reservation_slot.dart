import 'dart:convert';

ReservationSlotModel reservationSlotModelFromJson(String str) => ReservationSlotModel.fromJson(json.decode(str));

String reservationSlotModelToJson(ReservationSlotModel data) => json.encode(data.toJson());

class ReservationSlotModel {
  int code = 0;
  String error_message;
  List data;

  ReservationSlotModel({
    this.code,
    this.data,
    this.error_message,
  });

  factory ReservationSlotModel.fromJson(Map<String, dynamic> json) => ReservationSlotModel(
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
