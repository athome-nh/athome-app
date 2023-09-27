import 'package:shared_preferences/shared_preferences.dart';

///// The following methods are used to manage all types of shared preferences
Future<String> getStringPrefs(String key) async {
  String retrive = "";
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getString(key) ?? "");
  return retrive;
}

Future<int> getIntPrefs(String key) async {
  int retrive = 0;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getInt(key) ?? 0);
  return retrive;
}

Future<bool> getBoolPrefs(String key) async {
  bool retrive = false;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getBool(key) ?? false);
  return retrive;
}

Future<double> getDoublePrefs(String key) async {
  double retrive = 0;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getDouble(key) ?? 0);
  return retrive;
}

Future<List<String>> getStringListPrefs(String key) async {
  List<String> retrive = [];
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  retrive = (prefs.getStringList(key) ?? []);
  return retrive;
}

setStringPrefs(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

setIntPrefs(String key, int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

setBoolPrefs(String key, bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

setDoublePrefs(String key, double value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

setStringListPrefs(String key, List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);
}

clearPrifrences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
