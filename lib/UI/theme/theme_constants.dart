
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    caption: TextStyle(
      color: Colors.black
    )
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  primaryColor: Colors.white,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    refreshBackgroundColor: Colors.white70,
    circularTrackColor: Colors.black,
    color: Colors.black
  ),
    scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
    iconTheme: const IconThemeData(
      color: Colors.white70,
    ),
    textTheme: const TextTheme(
      caption: TextStyle(
        color: Colors.white70
      )
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,

    ),
    primaryColor: Colors.black,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        refreshBackgroundColor: Colors.white70,
      circularTrackColor: Colors.white70
    ),
  scaffoldBackgroundColor: Colors.grey
);