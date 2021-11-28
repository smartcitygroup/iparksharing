import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences _preferences;

  static const _keyWizzardStepper = 'wizzard_stepper';
  static const _keyUserEmail = 'user_email';
  static const _keyUserToken = 'user_token';
  static const _keySaveUserEmail = 'save_user_email';
  static const _keySaveUserPhone = 'save_user_phone';
  static const _keySaveUserFirstName = 'save_user_first_name';
  static const _keySaveUserSecondName = 'save_user_second_name';
  static const _keyUserWallet = 'user_wallet';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  //Wallet
  static Future saveUserWallet(String wallet) async =>
      await _preferences.setString(_keyUserWallet, wallet);

  static String getUserWallet() => _preferences.get(_keyUserWallet);

  //SaveUserSecondName
  static Future saveUserSecondName(String email) async =>
      await _preferences.setString(_keySaveUserSecondName, email);

  static String getSaveUserSecondName() =>
      _preferences.get(_keySaveUserSecondName);

  //SaveUserFirstName
  static Future saveUserFirstName(String email) async =>
      await _preferences.setString(_keySaveUserFirstName, email);

  static String getSaveUserFirstName() =>
      _preferences.get(_keySaveUserFirstName);

  // SaveUserPhone
  static Future saveUserPhone(String email) async =>
      await _preferences.setString(_keySaveUserPhone, email);

  static String getSaveUserPhone() => _preferences.get(_keySaveUserPhone);

  // SaveUserEmail
  static Future saveUserEmail(String email) async =>
      await _preferences.setString(_keySaveUserEmail, email);

  static String getSaveUserEmail() => _preferences.get(_keySaveUserEmail);

  // WizzardStepper
  static Future setWizzardStepper(bool stepper) async =>
      await _preferences.setBool(_keyWizzardStepper, stepper);

  static bool getWizzardStepper() => _preferences.get(_keyWizzardStepper);

  // User Email
  static Future setUserEmail(String useremail) async =>
      await _preferences.setString(_keyUserEmail, useremail);

  static bool getUserEmail() => _preferences.get(_keyUserEmail);

  // User Personal Token
  static Future setUserToken(String token) async =>
      await _preferences.setString(_keyUserToken, token);

  static String getUserToken() => _preferences.get(_keyUserToken);
}
