import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:email_validator/email_validator.dart';

class HomeModel extends ChangeNotifier {
  get isVisible => _isVisible;
  bool _isVisible = false;

  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  get isValid => _isValid;
  bool _isValid = false;

  get isValidNameCheck => _isValidNameCheck;
  bool _isValidNameCheck = false;

  get isValidSecondCheck => _isValidSecondCheck;
  bool _isValidSecondCheck = false;

  get isValidPhoneCheck => _isValidPhoneCheck;
  bool _isValidPhoneCheck = false;

  get isValidNameCarCheck => _isValidNameCarCheck;
  bool _isValidNameCarCheck = false;

  get isValidModelCarCheck => _isValidModelCarCheck;
  bool _isValidModelCarCheck = false;

  get isValidManufactureCheck => _isValidManufactureCheck;
  bool _isValidManufactureCheck = false;

  get isValidLicencePlateCheck => _isValidLicencePlateCheck;
  bool _isValidLicencePlateCheck = false;

  void isValidLicencePlate(String input) {
    if (input.length < 4) {
      _isValidLicencePlateCheck = false;
    } else {
      _isValidLicencePlateCheck = true;
    }
    notifyListeners();
  }

  void isValidManafacture(String input) {
    if (input.length < 2) {
      _isValidManufactureCheck = false;
    } else {
      _isValidManufactureCheck = true;
    }
    notifyListeners();
  }

  void isValidModelCar(String input) {
    if (input.length < 2) {
      _isValidModelCarCheck = false;
    } else {
      _isValidModelCarCheck = true;
    }
    notifyListeners();
  }

  void isValidNameCar(String input) {
    if (input.length < 4) {
      _isValidNameCarCheck = false;
    } else {
      _isValidNameCarCheck = true;
    }
    notifyListeners();
  }

  void isValidName(String input) {
    if (input.length < 2) {
      _isValidNameCheck = false;
    } else {
      _isValidNameCheck = true;
    }
    notifyListeners();
  }

  void isValidSecondName(String input) {
    if (input.length < 4) {
      _isValidSecondCheck = false;
    } else {
      _isValidSecondCheck = true;
    }
    notifyListeners();
  }

  void isValidPhone(String input) {
    if (input.length < 6) {
      _isValidPhoneCheck = false;
    } else {
      _isValidPhoneCheck = true;
    }
    notifyListeners();
  }

  void isValidEmail(String input) {
    if (EmailValidator.validate(input)) {
      _isValid = true;
    } else {
      _isValid = false;
    }
    notifyListeners();
  }
}
