import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';

class CustomStyle {
  static double minDefaultExtend = 0.30;
  static double maxDefaultExtend = 0.50;
  static double minDefaultGoogleMapPadding = 0.30;
  static double maxDefaultGoogleMapPadding = 0.50;
  static double cornerPadding = 15;

  static var materialButton = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      color: iParkColors.mainBackGroundcolor);

  static var textStyle = TextStyle(
      fontSize: Dimensions.defaultTextSize,);

  static var hintTextStyle = TextStyle(
      color: Colors.grey.withOpacity(0.5),
      fontSize: Dimensions.defaultTextSize,
      fontFamily: 'Poppins-SemiBold');


  static var listStyle = TextStyle(
      fontSize: Dimensions.defaultTextSize, );

  static var listStyleBold = TextStyle(
      fontSize: Dimensions.defaultTextSize,
      fontWeight: FontWeight.w800);

  static var defaultStyle = TextStyle(
      fontSize: Dimensions.largeTextSize,);

  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
  );

  static var searchBox = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
  );
}