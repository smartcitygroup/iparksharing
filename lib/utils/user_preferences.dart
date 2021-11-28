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
  static const _keySaveCountTicket = 'ticket_counts';
  static const _keySaveCountVehicles = 'ticket_vehicles';
  static const _keySaveCountTransactions = 'ticket_transactions';
  static const _keySaveUserID = 'save_user_id';
  static const _keyDataMarker = 'data_markers';
  static const _keyTheme = 'user_theme';
  static const _keyUserLanguage = 'user_lang';
  static const _keyUserLanguageOther = 'user_lang_other';
  static const _keyVersionOfApp = 'user_lang_other';
  static const _keyUserWallet = 'user_wallet';
  static const _keyPaymentId = 'payment_id';
  static const _keySaveWizardScanTicket = 'wizard_scan_ticket';
  static const _keySortByNotPaid = 'sort_by_not_paid';
  static const _keySortByPrice = 'sort_by_price';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveCountTransactions(int transaction) async =>
      await _preferences.setInt(_keySaveCountTransactions, transaction);

  static int getCountTransactions() =>
      _preferences.getInt(_keySaveCountTransactions);

  static Future saveCountVehicles(int vehicles) async =>
      await _preferences.setInt(_keySaveCountVehicles, vehicles);

  static int getCountVehicles() => _preferences.getInt(_keySaveCountVehicles);

  static Future saveCountTickets(int tickets) async =>
      await _preferences.setInt(_keySaveCountTicket, tickets);

  static int getCountTickets() => _preferences.get(_keySaveCountTicket);

  //Sort by not paid
  static Future saveSortByNotPaid(bool wizard) async =>
      await _preferences.setBool(_keySortByNotPaid, wizard);

  static bool getSortByNotPaid() => _preferences.get(_keySortByNotPaid);

  //WizardScanTicket
  static Future saveWizardScanTicket(bool wizard) async =>
      await _preferences.setBool(_keySaveWizardScanTicket, wizard);

  static bool getWizardScanTicket() =>
      _preferences.get(_keySaveWizardScanTicket);

  //PaymentID
  static Future savePaymentID(int payment_id) async =>
      await _preferences.setInt(_keyPaymentId, payment_id);

  static int getPaymentID() => _preferences.get(_keyPaymentId);

  //Wallet
  static Future saveUserWallet(String wallet) async =>
      await _preferences.setString(_keyUserWallet, wallet);

  static String getUserWallet() => _preferences.get(_keyUserWallet);

  //VersionOfApp
  static Future saveVersionOfApp(String version) async =>
      await _preferences.setString(_keyVersionOfApp, version);

  static String getVersionOfApp() => _preferences.get(_keyVersionOfApp);

  //UserTheme
  static Future saveUserTheme(bool theme) async =>
      await _preferences.setBool(_keyTheme, theme);

  static bool getUserTheme() => _preferences.get(_keyTheme);

  //userLang
  static Future saveUserLanguage(String lang) async =>
      await _preferences.setString(_keyUserLanguage, lang);

  static String getUserLanguage() => _preferences.get(_keyUserLanguage);

  //userlangother
  static Future saveUserLanguageOther(String lang) async =>
      await _preferences.setString(_keyUserLanguageOther, lang);

  static String getUserLanguageOther() =>
      _preferences.get(_keyUserLanguageOther);

  //SaveMarkers
  static Future saveDataMarker(List data) async =>
      await _preferences.setStringList(_keyDataMarker, data);

  static List getDataMarker() => _preferences.get(_keyDataMarker);

  //SaveUserID
  static Future saveUserID(int ID) async =>
      await _preferences.setInt(_keySaveUserID, ID);

  static int getSaveUserID() => _preferences.get(_keySaveUserID);

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
