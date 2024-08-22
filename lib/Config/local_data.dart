// Import necessary packages and libraries
import 'package:shared_preferences/shared_preferences.dart';

/// The following methods are used to manage all types of shared preferences.
/// Shared preferences allow you to store simple key-value pairs persistently in the device's storage.

/// Retrieves a String value from shared preferences for the given key.
/// If the key doesn't exist, it returns an empty string.
Future<String> getStringPrefs(String key) async {
  String retrive = "";
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getString(key) ?? "");  // Fallback to an empty string if the key is not found.
  return retrive;
}

/// Retrieves an integer value from shared preferences for the given key.
/// If the key doesn't exist, it returns 0.
Future<int> getIntPrefs(String key) async {
  int retrive = 0;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getInt(key) ?? 0);  // Fallback to 0 if the key is not found.
  return retrive;
}

/// Retrieves a boolean value from shared preferences for the given key.
/// If the key doesn't exist, it returns false.
Future<bool> getBoolPrefs(String key) async {
  bool retrive = false;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getBool(key) ?? false);  // Fallback to false if the key is not found.
  return retrive;
}

/// Retrieves a double value from shared preferences for the given key.
/// If the key doesn't exist, it returns 0.0.
Future<double> getDoublePrefs(String key) async {
  double retrive = 0.0;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getDouble(key) ?? 0.0);  // Fallback to 0.0 if the key is not found.
  return retrive;
}

/// Retrieves a List of Strings from shared preferences for the given key.
/// If the key doesn't exist, it returns an empty list.
Future<List<String>> getStringListPrefs(String key) async {
  List<String> retrive = [];
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getStringList(key) ?? []);  // Fallback to an empty list if the key is not found.
  return retrive;
}

/// Stores a String value in shared preferences for the given key.
setStringPrefs(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);  // Stores the string value.
}

/// Stores an integer value in shared preferences for the given key.
setIntPrefs(String key, int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);  // Stores the integer value.
}

/// Stores a boolean value in shared preferences for the given key.
setBoolPrefs(String key, bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);  // Stores the boolean value.
}

/// Stores a double value in shared preferences for the given key.
setDoublePrefs(String key, double value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);  // Stores the double value.
}

/// Stores a List of Strings in shared preferences for the given key.
setStringListPrefs(String key, List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);  // Stores the list of strings.
}

/// Clears all the data stored in shared preferences.
clearPrifrences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();  // Removes all keys and their associated values from shared preferences.
}
