// Import necessary packages and dependencies
import 'package:dllylas/Config/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  // Light theme configuration for the app
  static final lightTheme1 = ThemeData(
    // Configuration for dialogs
    dialogTheme: DialogTheme(
      backgroundColor: mainColorWhite, // Background color of dialogs
    ),
    // Configuration for popup menus
    popupMenuTheme: PopupMenuThemeData(color: mainColorWhite), // Background color of popup menus
    // Configuration for dividers
    dividerTheme: DividerThemeData(color: mainColorBlack.withOpacity(0.2)), // Color of dividers
    // Configuration for buttons
    buttonTheme: ButtonThemeData(buttonColor: mainColorGrey), // Default button color
    // Configuration for text buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
            color: mainColorWhite, fontFamily: mainFontnormal, fontSize: 14), // Text style for text buttons
        foregroundColor: mainColorWhite, // Foreground color for text buttons
        backgroundColor: mainColorGrey, // Background color for text buttons
        disabledBackgroundColor: Colors.grey[300], // Background color when disabled
        disabledForegroundColor: mainColorBlack.withOpacity(0.8), // Foreground color when disabled
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Border radius for text buttons
        ),
      ),
    ),
    // Configuration for elevated buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
            color: mainColorWhite, fontFamily: mainFontnormal, fontSize: 14), // Text style for elevated buttons
        foregroundColor: mainColorWhite, // Foreground color for elevated buttons
        backgroundColor: mainColorGrey, // Background color for elevated buttons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Border radius for elevated buttons
        ),
      ),
    ),
    useMaterial3: true, // Enable Material 3 design
    // Color scheme configuration
    colorScheme: ColorScheme.fromSeed(
        primary: mainColorGrey, // Primary color for the theme
        secondary: mainColorRed, // Secondary color for the theme
        background: mainColorWhite, // Background color for the theme
        brightness: Brightness.light, // Theme brightness (light mode)
        surfaceTint: mainColorWhite, // Surface tint color
        seedColor: mainColorGrey), // Seed color for the color scheme
    scaffoldBackgroundColor: mainColorWhite, // Background color for Scaffold widgets
    // Configuration for AppBar
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: mainColorGrey, size: 25), // Icon theme for actions in AppBar
      iconTheme: IconThemeData(color: mainColorGrey), // Icon theme for AppBar icons
      centerTitle: true, // Center title in AppBar
      elevation: 0, // Elevation of AppBar
      surfaceTintColor: mainColorWhite, // Surface tint color for AppBar
      titleTextStyle: TextStyle(
          color: mainColorBlack, fontSize: 20, fontFamily: mainFontnormal), // Text style for AppBar title
      backgroundColor: mainColorWhite, // Background color of AppBar
    ),
  );

  // Dark theme configuration for the app
  static final darkTheme2 = ThemeData(
    // Configuration for canvas color (background of app elements)
    canvasColor: Color(0xff1A3848), // Dark canvas color
    primaryColor: const Color(0xff2382AA), // Primary color for the theme
    // Color scheme configuration for dark mode
    colorScheme: ColorScheme.dark(
        background: Color(0xff0D1F29), // Background color for dark mode
        primary: Color(0xff98A2B3), // Primary color for dark mode
        secondary: Colors.grey[800]!), // Secondary color for dark mode
    // Configuration for bottom navigation bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff2382AA), // Background color of bottom navigation bar
      selectedItemColor: Color.fromARGB(255, 255, 255, 255), // Color for selected items
      unselectedItemColor: Colors.grey, // Color for unselected items
    ),
    // Configuration for card background color
    cardColor: Color(0xff1A3848), // Background color of cards
    // Configuration for text theme
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)), // Text style for body text
    brightness: Brightness.dark, // Theme brightness (dark mode)
    // Configuration for AppBar in dark mode
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light, // System UI overlay style for AppBar
      elevation: 0, // Elevation of AppBar
      surfaceTintColor: Color(0xff2382AA), // Surface tint color for AppBar
      shadowColor: Color(0xff2382AA), // Shadow color for AppBar
      backgroundColor: Color(0xff0D1F29), // Background color of AppBar
    ),
    // Configuration for input decoration (e.g., text fields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // Enable filled background for input fields
      fillColor: Color(0xff1A3848), // Background color of input fields
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8.0), // Border radius for input fields
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8.0), // Border radius for focused input fields
      ),
      constraints: BoxConstraints.expand(height: 48), // Height constraint for input fields
    ),
    // Configuration for dropdown menus
    dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0), // Border radius for dropdown menu input
            borderSide: BorderSide(width: 2, color: Color(0xff2382AA)), // Border color
          ),
          isDense: true, // Reduce density for dropdown menu content
          contentPadding: const EdgeInsets.symmetric(horizontal: 16), // Padding inside dropdown menu
          constraints: BoxConstraints.tight(const Size.fromHeight(40)), // Height constraint for dropdown menu
        ),
        menuStyle: MenuStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(Color.fromARGB(255, 26, 56, 72)), // Background color of dropdown menu
        )),
  );
}
