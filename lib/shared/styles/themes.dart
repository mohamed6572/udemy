import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gps_tracker/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'test',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'test',
    ),
    subtitle1: TextStyle(
      color: Colors.white,
      fontSize: 14,
      height: 1.3,
      fontWeight: FontWeight.w600,

    ),
  ),
  primarySwatch: DefultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    backgroundColor: HexColor('333749'),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333749'),
        statusBarIconBrightness: Brightness.light),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333749'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 20,
      selectedItemColor: DefultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333749')),
);
ThemeData lightTheme = ThemeData(
  fontFamily: 'test',
  textTheme: const TextTheme(
    bodyText1: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'test',
    ),
    subtitle1: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      height: 1.3,
      fontWeight: FontWeight.w600,

    ),
  ),
  primarySwatch: DefultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 20,
      selectedItemColor: DefultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white),
);
