import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF5d74e3),
    backgroundColor: Color(0xFFf3f6fb),
    canvasColor: Color(0xFFf3f6fb),
    popupMenuTheme: PopupMenuThemeData(color: Color(0xFFEDF0F6)),
    cardColor: Colors.white,
    dividerColor: Colors.black,
    bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFFa8ccf0)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.black.withOpacity(.75)),
    buttonColor: Color(0xFF5d74e3),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xFFf3f6fb)),
    hintColor: Colors.black38,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.black,
        hintStyle: TextStyle(
            fontFamily: 'Poppins-Medium',
            color: Colors.black38,
            fontSize: 21.0)),
    textTheme: TextTheme(
        title: TextStyle(
            fontFamily: 'Poppins-Bold',
            color: Colors.black,
            fontSize: 23.0,
            decoration: TextDecoration.none),
        body1: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 16.0,
            decoration: TextDecoration.none,
            color: Colors.black),
        display1: TextStyle(
            fontFamily: 'Poppins-Bold', color: Colors.black, fontSize: 21.0),
        display2: TextStyle(
            fontFamily: 'Poppins-Medium,', color: Colors.black, fontSize: 18.0),
        display3: TextStyle(
            color: Colors.black54, fontFamily: 'Poppins-Bold', fontSize: 15.0),
        display4: TextStyle(
            color: Colors.black, fontFamily: 'Poppins-Medium', fontSize: 21.0),
        headline: TextStyle(
            color: Colors.black, fontFamily: 'Poppins-Bold', fontSize: 25.0),
        button: TextStyle(
            fontFamily: 'Poppins-Bold', fontSize: 15.0, color: Colors.white)),
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF5d74e3),
    backgroundColor: Color(0xFF1b1e44),
    canvasColor: Color(0xFF1b1e44),
    popupMenuTheme: PopupMenuThemeData(color: Color(0xFF2d3447)),
    cardColor: Color(0xFF2d3447),
    dividerColor: Colors.white,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.black.withOpacity(.25)),
    buttonColor: Colors.black.withOpacity(.40),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xFF2d3447)),
    hintColor: Colors.white30,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        hintStyle: TextStyle(
            fontFamily: 'Poppins-Medium',
            color: Colors.white30,
            fontSize: 21.0)),
    textTheme: TextTheme(
      title: TextStyle(
          fontFamily: 'Poppins-Bold',
          color: Colors.white,
          fontSize: 23.0,
          decoration: TextDecoration.none),
      body1: TextStyle(
          fontFamily: 'Poppins-Medium',
          fontSize: 16.0,
          decoration: TextDecoration.none,
          color: Colors.white),
      display1: TextStyle(
          fontFamily: 'Poppins-Bold', color: Colors.white, fontSize: 21.0),
      display2: TextStyle(
          fontFamily: 'Poppins-Medium,', color: Colors.white, fontSize: 18.0),
      display3: TextStyle(
          color: Colors.white54, fontFamily: 'Poppins-Bold', fontSize: 15.0),
      display4: TextStyle(
          color: Colors.white, fontFamily: 'Poppins-Medium', fontSize: 21.0),
      headline: TextStyle(
          color: Colors.white, fontFamily: 'Poppins-Bold', fontSize: 25.0),
      button: TextStyle(
          fontFamily: 'Poppins-Bold', fontSize: 15.0, color: Color(0xFF5d74e3)),
    ),
  )
};
