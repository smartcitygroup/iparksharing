import 'dart:convert';

GetInfoModel getInfoModelFromJson(String str) =>
    GetInfoModel.fromJson(json.decode(str));

String codeCheckModelToJson(GetInfoModel data) => json.encode(data.toJson());

class GetInfoModel {
  int code = 0;
  String error_message;
  String first_name, second_name, phone, email, preference_lang;
  String wallet;
  int last_activity, tickets_count, vehicles_count, transactions_count;
  bool preference_dark_theme;


  GetInfoModel(
      {this.code,
      this.error_message,
      this.first_name,
      this.second_name,
      this.email,
      this.phone,
      this.preference_lang,
      this.preference_dark_theme,
      this.wallet,
      this.last_activity,
      this.tickets_count,
      this.transactions_count,
      this.vehicles_count});

  factory GetInfoModel.fromJson(Map<String, dynamic> json) => GetInfoModel(
    code: json["code"],
    error_message: json["error_message"],
    first_name: json["data"] == null
        ? null
        : json["data"]["full_name"]["first_name"],
    second_name: json["data"] == null
        ? null
        : json["data"]["full_name"]["last_name"],
    email: json["data"] == null ? null : json["data"]["email"],
    phone: json["data"] == null ? null : json["data"]["phone"],
    preference_lang: json["data"] == null
        ? null
        : json["data"]["preference_lang"],
    preference_dark_theme: json["data"] == null
        ? null
        : json["data"]["preference_dark_theme"],
    wallet: json["data"] == null ? null : json["data"]["wallet"],
    last_activity: json["data"] == null ? null : json["data"]["last_activity"],
    tickets_count: json["data"] == null ? null : json["data"]["tickets_count"],
    vehicles_count: json["data"] == null
        ? null
        : json["data"]["vehicles_count"],
    transactions_count: json["data"] == null
        ? null
        : json["data"]["transactions_count"],
      );

  Map<String, dynamic> toJson() =>
      {
        "code": code,
        "error_message": error_message,
        "first_name": first_name == null ? null : first_name,
        "last_name": second_name == null ? null : second_name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "preferences_lang": preference_lang == null ? null : preference_lang,
        "preferences_dark_theme": preference_dark_theme == null
            ? null
            : preference_dark_theme,
        "wallet": wallet == null ? null : wallet,
        "last_activity": last_activity == null ? null : last_activity,
        "tickets_count": tickets_count == null ? null : tickets_count,
        "vehicles_count": vehicles_count == null ? null : vehicles_count,
        "transactions_count": transactions_count == null
            ? null
            : transactions_count,
      };
}
