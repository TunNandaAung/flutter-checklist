import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }

final appThemeData = {
  AppTheme.Light: ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5d74e3),
    primarySwatch: Colors.indigo,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0xFF5d74e3),
        ),
    highlightColor: Colors.black26,
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xfff5f9ff)),
    backgroundColor: const Color(0xFFf3f6fb),
    canvasColor: const Color(0xFFf3f6fb),
    popupMenuTheme: const PopupMenuThemeData(color: Color(0xFFEDF0F6)),
    cardColor: Colors.white,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
    dividerColor: Colors.black,
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF98c6f5)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.black.withOpacity(.75)),
    primaryColorLight: const Color(0xFF5d74a1),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Color(0xFFf3f6fb)),
    hintColor: Colors.black38,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.black,
      hintStyle: TextStyle(
        fontFamily: 'Poppins-Medium',
        color: Colors.black38,
        fontSize: 21.0,
        decoration: TextDecoration.none,
      ),
    ),
    textTheme: const TextTheme(
        headline6: TextStyle(
          fontFamily: 'Poppins-Bold',
          color: Colors.black,
          fontSize: 23.0,
          decoration: TextDecoration.none,
        ),
        bodyText1: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 16.0,
            decoration: TextDecoration.none,
            color: Colors.black),
        bodyText2: TextStyle(
          fontFamily: 'Poppins-Medium',
          fontSize: 16.0,
          decoration: TextDecoration.none,
          color: Colors.grey,
        ),
        headline4: TextStyle(
          fontFamily: 'Poppins-Bold',
          color: Colors.black,
          fontSize: 30.0,
          decoration: TextDecoration.none,
        ),
        headline3: TextStyle(
            fontFamily: 'Poppins-Medium,',
            color: Colors.black,
            fontSize: 18.0,
            decoration: TextDecoration.none),
        headline2: TextStyle(
          color: Colors.black54,
          fontFamily: 'Poppins-Bold',
          fontSize: 15.0,
          decoration: TextDecoration.none,
        ),
        headline1: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins-Medium',
          fontSize: 21.0,
          decoration: TextDecoration.none,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins-Bold',
          fontSize: 25.0,
          decoration: TextDecoration.none,
        ),
        subtitle1: TextStyle(decoration: TextDecoration.none),
        subtitle2: TextStyle(decoration: TextDecoration.none),
        caption: TextStyle(decoration: TextDecoration.none),
        button: TextStyle(
            fontFamily: 'Poppins-Bold',
            fontSize: 15.0,
            color: Colors.white,
            decoration: TextDecoration.none)),
  ),
  AppTheme.Dark: ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5d74e3),
    primarySwatch: Colors.indigo,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0xFF5d74e3),
        ),
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    backgroundColor: const Color(0xFF1A202C),
    canvasColor: const Color(0xFF1A202C),
    popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF2d3447)),
    cardColor: const Color(0xFF2d3447),
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xFF2d3447),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    dividerColor: Colors.white,
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.black),
    primaryColorLight: Colors.black.withOpacity(.50),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF2d3447),
    ),
    hintColor: Colors.white30,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
      hintStyle: TextStyle(
        fontFamily: 'Poppins-Medium',
        color: Colors.white30,
        fontSize: 21.0,
        decoration: TextDecoration.none,
      ),
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(
        fontFamily: 'Poppins-Bold',
        color: Colors.white,
        fontSize: 23.0,
        decoration: TextDecoration.none,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Poppins-Medium',
        fontSize: 16.0,
        decoration: TextDecoration.none,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Poppins-Medium',
        fontSize: 16.0,
        decoration: TextDecoration.none,
        color: Colors.grey,
      ),
      headline4: TextStyle(
        fontFamily: 'Poppins-Bold',
        color: Colors.white,
        fontSize: 30.0,
        decoration: TextDecoration.none,
      ),
      headline3: TextStyle(
        fontFamily: 'Poppins-Medium,',
        color: Colors.white,
        fontSize: 18.0,
        decoration: TextDecoration.none,
      ),
      headline2: TextStyle(
        color: Colors.white54,
        fontFamily: 'Poppins-Bold',
        fontSize: 15.0,
        decoration: TextDecoration.none,
      ),
      headline1: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins-Medium',
        fontSize: 21.0,
        decoration: TextDecoration.none,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins-Bold',
        fontSize: 25.0,
        decoration: TextDecoration.none,
      ),
      subtitle1: TextStyle(decoration: TextDecoration.none),
      subtitle2: TextStyle(decoration: TextDecoration.none),
      caption: TextStyle(decoration: TextDecoration.none),
      button: TextStyle(
        fontFamily: 'Poppins-Bold',
        fontSize: 15.0,
        color: Color(0xFF5d74e3),
        decoration: TextDecoration.none,
      ),
    ),
  )
};
