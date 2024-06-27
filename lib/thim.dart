import 'package:dllylas/Config/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static final lightTheme1 = ThemeData(
    dialogTheme: DialogTheme(
      backgroundColor:
          mainColorWhite, // Set the background color of AlertDialog
    ),
    popupMenuTheme: PopupMenuThemeData(color: mainColorWhite),
    dividerTheme: DividerThemeData(color: mainColorBlack.withOpacity(0.2)),
    buttonTheme: ButtonThemeData(buttonColor: mainColorGrey),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
            color: mainColorWhite, fontFamily: mainFontnormal, fontSize: 14),
        foregroundColor: mainColorWhite, // Text color of the button
        backgroundColor: mainColorGrey, // Background color of the button
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), // Border radius of the button
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
            color: mainColorWhite, fontFamily: mainFontnormal, fontSize: 14),
        foregroundColor: mainColorWhite, // Text color of the button
        backgroundColor: mainColorGrey, // Background color of the button
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), // Border radius of the button
        ),
      ),
    ),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        primary: mainColorGrey,
        secondary: mainColorRed,
        background: mainColorWhite,
        brightness: Brightness.light,
        surfaceTint: mainColorWhite,
        seedColor: mainColorGrey),
    scaffoldBackgroundColor: mainColorWhite,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: mainColorGrey, size: 25),
      iconTheme: IconThemeData(color: mainColorGrey),
      centerTitle: true,
      elevation: 0,
      surfaceTintColor: mainColorWhite,
      titleTextStyle: TextStyle(
          color: mainColorBlack, fontSize: 20, fontFamily: mainFontnormal),
      backgroundColor: mainColorWhite,
    ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   showUnselectedLabels: false,
    //   selectedItemColor: mainColorGrey,
    //   unselectedItemColor: mainColorGrey,
    //   backgroundColor: mainColorWhite,
    //   type: BottomNavigationBarType.fixed,
    // ),
  );

  static final darkTheme2 = ThemeData(
    canvasColor: Color(0xff1A3848),
    primaryColor: const Color(0xff2382AA),
    colorScheme: ColorScheme.dark(
        background: Color(0xff0D1F29),
        primary: Color(0xff98A2B3),
        secondary: Colors.grey[800]!),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff2382AA),
      selectedItemColor:
          Color.fromARGB(255, 255, 255, 255), // Selected item color
      unselectedItemColor: Colors.grey, // Unselected item color
    ),
    cardColor: Color(0xff1A3848),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      surfaceTintColor: Color(0xff2382AA),
      shadowColor: Color(0xff2382AA),
      backgroundColor: Color(0xff0D1F29),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xff1A3848),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      constraints: BoxConstraints.expand(height: 48),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 2, color: Color(0xff2382AA)),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: BoxConstraints.tight(const Size.fromHeight(40)),
        ),
        menuStyle: MenuStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(Color.fromARGB(255, 26, 56, 72)),
        )),
  );
}
