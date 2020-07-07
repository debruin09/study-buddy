import 'package:flutter/material.dart';

class AppTheme {
  static const themeColor = Color(0xffF2EEED); //  Color(0xffE26D5C);
  static const textColor = Color(0xff4B4B49);
  static const iconColor = Color(0xff4C5F6B);
  static const cardSecColor = Color(0xffF8E2CF);
  static const bgColor = Color(0xffECE4DD);

  static const cardColor = Color(0xffFD866E);
  static final ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: cardColor,
        iconTheme: IconThemeData(
          color: iconColor,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: iconColor,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        )),
    backgroundColor: themeColor,
    primaryColor: textColor,
    buttonColor: themeColor,
    accentColor: bgColor,
    iconTheme: IconThemeData(
      color: iconColor,
    ),
    fontFamily: "PostNoBillsColombo",
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headline6: TextStyle(
          fontSize: 24.0,
          fontStyle: FontStyle.italic,
          color: textColor,
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          fontSize: 18.0,
          color: textColor,
          fontFamily: 'Hind',
          fontWeight: FontWeight.bold),
      bodyText2:
          TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: textColor),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: themeColor,
      textTheme: ButtonTextTheme.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    ),
  );
}
