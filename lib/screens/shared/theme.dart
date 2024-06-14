import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0x0fffffff);
  static const Color darkPrimary = Color(0xFFF141A2E);
  static var lightTheme = ThemeData(
      primaryColor: const Color.fromARGB(255, 40, 205, 196),
      scaffoldBackgroundColor: Colors.white,
      // primaryColor: lightPrimary,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        //centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 84, 84, 84),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black54),
      cardTheme: const CardTheme(
        color: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 217, 217, 217),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
          color: Color.fromARGB(255, 40, 205, 196),
          size: 30,
        ),
        unselectedIconTheme: IconThemeData(
          color: Color.fromARGB(255, 84, 84, 84),
          size: 24,
        ),
        selectedLabelStyle: TextStyle(
          color: Color.fromARGB(255, 40, 205, 196),
        ),
        selectedItemColor: Color.fromARGB(255, 40, 205, 196),
      ),
      textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 12, color: Colors.black54),
          bodyLarge: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 84, 84, 84),
          ),
        displayMedium:TextStyle(
          color: Color.fromARGB(255, 84, 84, 84),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ) ,
      ));

  static var darkTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 40, 205, 196),
    textTheme: const TextTheme(
      displayMedium:TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ) ,
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: const Color.fromARGB(255, 28, 35, 49),
    //primaryColor: Color.fromARGB(255, 99, 155, 151),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      //centerTitle: true,
      backgroundColor: Color.fromARGB(255, 28, 35, 49),
      //elevation: 0,
      titleTextStyle: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
    cardTheme: const CardTheme(color: Color.fromARGB(108, 241, 255, 255)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 64, 76, 85),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        color: Color.fromARGB(255, 84, 84, 84),
        size: 24,
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.white,
      ),
      selectedItemColor: Colors.white,
    ),
  );
}
