import 'dart:convert';

GetLotsInfoModel getlotsInfoModelFromJson(String str) => GetLotsInfoModel.fromJson(json.decode(str));

String getlotsInfoModelToJson(GetLotsInfoModel data) => json.encode(data.toJson());

class GetLotsInfoModel {
  int code = 0;
  int ID;
  double lat;
  double lon;
  String name;
  String lore;
  int user_id;
  String place_special_ID;
  int is_on_open_place;
  String contact_phone;
  String contact_email;

  GetLotsInfoModel({
    this.code,
    this.contact_email,
    this.lore,
    this.contact_phone,
    this.ID,
    this.lat,
    this.is_on_open_place,
    this.place_special_ID,
    this.name,
    this.user_id,
    this.lon
  });

  factory GetLotsInfoModel.fromJson(Map<String, dynamic> json) => GetLotsInfoModel(
        code: json["code"],
        contact_email: json["data"] == null ? null : json["data"]["contact_email"],
    lore: json["data"] == null ? null : json["data"]["lore"],
    contact_phone: json["data"] == null ? null : json["data"]["contact_phone"],
    ID: json["data"] == null ? null : json["data"]["ID"],
    lat: json["data"] == null ? null : json["data"]["lat"],
    is_on_open_place: json["data"] == null ? null : json["data"]["is_on_open_place"],
    place_special_ID: json["data"] == null ? null : json["data"]["place_special_ID"],
    name: json["data"] == null ? null : json["data"]["name"],
    user_id: json["data"] == null ? null : json["data"]["user_id"],
    lon: json["data"] == null ? null : json["data"]["lng"],
      );

  Map<String, dynamic> toJson() =>
      {
        "code": code,
        "contact_email": contact_email == null ? null : contact_email,
        "lore": lore == null ? null : lore,
        "contact_phone": contact_phone == null ? null : contact_phone,
        "ID": ID == null ? null : ID,
        "lat": lat == null ? null : lat,
        "is_on_open_place": is_on_open_place == null ? null : is_on_open_place,
        "place_special_ID": place_special_ID == null ? null : place_special_ID,
        "name": name == null ? null : name,
        "user_id": user_id == null ? null : user_id,
        "lon": lon == null ? null : lon,
      };
}
