import 'dart:convert';
import 'dart:io';

import 'package:athome/main.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encryption;
import 'package:ntp/ntp.dart';
import 'package:path_provider/path_provider.dart';

//// a fast way to push to a new screen
void to(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

//// a fast way to push to a new screen and cut the previous route
void toOff(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
    (Route<dynamic> route) => false,
  );
  
}

//// check allowed image extentions
bool isImageValidaty(String path) {
  path = path.toLowerCase();
  if (path.endsWith(".png") ||
      path.endsWith(".jpg") ||
      path.endsWith(".jpeg")) {
    return true;
  } else {
    return false;
  }
}

//// Cut text length according to the parameter
String textCount(String txt, int num) {
  String r = "";

  if (txt.length > num) {
    r = "${txt.substring(0, num)}...";
  } else {
    r = txt;
  }

  return r;
}

String encryptAES(String plainText) {
  if (plainText.isEmpty) {
    return "";
  }
  final key = encryption.Key.fromUtf8('1#qw34?r5tgvfdcx>Az678u!jnbg&Klp');
  final iv = encryption.IV.fromLength(16);
  final encrypter = encryption.Encrypter(
      encryption.AES(key, mode: encryption.AESMode.ctr, padding: null));
  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}

Future<int> getOnlineTimestamp() async {
  DateTime startDate = await NTP.now();
  return startDate.hour;
}

String decryptAES(String ciphertext) {
  if (ciphertext.isEmpty) {
    return "";
  }
  final key = encryption.Key.fromUtf8('1#qw34?r5tgvfdcx>Az678u!jnbg&Klp');
  final iv = encryption.IV.fromLength(16);
  final decrypter = encryption.Encrypter(
      encryption.AES(key, mode: encryption.AESMode.ctr, padding: null));
  final decrypted = decrypter
      .decryptBytes(encryption.Encrypted.fromBase64(ciphertext), iv: iv);
  final decryptedData = utf8.decode(decrypted);

  return decryptedData.toString();
}

/// Main {}
Future<DateTime> getDatetime(BuildContext context) async {
  DateTime selectedDate = DateTime.now();

  final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 29)));

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  return selectedDate;
}

Future<DateTime> getDatetime2(BuildContext context) async {
  DateTime selectedDate = DateTime.now();

  final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 29)));
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  return selectedDate;
}

Future<bool> Save_data_josn(String filename, Map data) async {
  try {
    final directory = await getTemporaryDirectory();
    String path = "${directory.path}/${filename}.json";
    File f = File(path);
    var jsonData = json.encode(data);
    f.writeAsStringSync(encryptAES(jsonData),
        flush: true, mode: FileMode.write);
    return true;
  } catch (e) {
    return false;
  }
}

Future<Map> Load_data_josn(String filename) async {
  final directory = await getTemporaryDirectory();
  String path = "${directory.path}/${filename}.json";
  File f = File(path);
  if (f.existsSync()) {
    final jsonData = f.readAsStringSync();
    var data = json.decode(decryptAES(jsonData));
    print(data);
    return data;
    //  return (data as List).map((x) => DictData.fromJson(x)).toList();
  } else {
    return {};
  }
}

String addCommasToPrice(int price) {
  // Convert the price to a string with two decimal places
  String formattedPrice = price.toStringAsFixed(0);

  // Split the formatted price into parts before and after the decimal point
  List<String> parts = formattedPrice.split('.');

  // Add commas to the integer part of the price
  String integerPart = parts[0];
  String integerWithCommas = '';
  for (int i = 0; i < integerPart.length; i++) {
    if (i > 0 && (integerPart.length - i) % 3 == 0) {
      integerWithCommas += ',';
    }
    integerWithCommas += integerPart[i];
  }

  // Combine the integer part with the decimal part and return the result
  if (parts.length == 1) {
    // If there is no decimal part, return just the integer part
    return integerWithCommas + " IQD";
  } else {
    return '$integerWithCommas.${parts[1]}';
  }
}

String calculatePercentageDiscount(
    double originalPrice, double discountedPrice) {
  if (originalPrice <= 0 ||
      discountedPrice <= 0 ||
      originalPrice <= discountedPrice) {
    return 'N/A'; // Handle invalid or zero values, or when the original price is less than or equal to the discounted price.
  }

  double discountAmount = originalPrice - discountedPrice;
  double percentageDiscount = (discountAmount / originalPrice) * 100;

  return '${percentageDiscount.toStringAsFixed(0)}%';
}

String fontBoldChoose() {
  String font = lang == "en" ? "" : "";
  return font;
}

String fontNormalChoose() {
  String font = lang == "en" ? "" : "";
  return font;
}
String getOflineTimestamp() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

Future<String> getOnlineTimestamp() async {
  DateTime startDate = await NTP.now();
  return startDate.millisecondsSinceEpoch.toString();
}





/// #Check this CODEs Latter

// ignore_for_file: unrelated_type_equality_checks
// import 'dart:convert';
// import 'dart:io';
// import 'package:barber/configs/app_color.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:interval_time_picker/interval_time_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:ntp/ntp.dart';
// import 'package:encrypt/encrypt.dart' as encryption;
// import 'app_color.dart';
// String formatTime(int seconds) {
//   return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
// }

// Future<bool> checktime(BuildContext context) async {
//   DateTime _myTime;
//   DateTime _ntpTime;
//   bool retrive = false;

// /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
// _myTime = DateTime.now();

// /// Or get NTP offset (in milliseconds) and add it yourself
// final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
// _ntpTime = _myTime.add(Duration(milliseconds: offset));

//   if ((_ntpTime.difference(_myTime).inMinutes) >= 1 ||
//       (_ntpTime.difference(_myTime).inMinutes) <= -1) {
//     retrive = true;
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Container(
//           child: Text(
//             "Your mobile phone time is not correct! Please update it in your phone Settings.",
//             style: TextStyle(
//               color: textcolor,
//               fontFamily: "RK",
//             ),
//           ),
//         ),
//         backgroundColor: buttonGrey,
//       ),
//     );
//   } else {
//     retrive = false;
//   }
//   return retrive;
// }

// ///// here we check for internet availability
// Future<bool> checkInternet(BuildContext context) async {
//   bool retrive = false;
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     retrive = false;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     retrive = false;
//   } else {
//     retrive = true;
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Container(
//           child: Text(
//             'No internet connection, check your connection',
//             style: TextStyle(
//               color: textcolor,
//               fontFamily: "RK",
//             ),
//           ),
//         ),
//         backgroundColor: buttonGrey,
//       ),
//     );
//   }
//   return retrive;
// }

// Future noInternet(BuildContext context) {
//   return checkInternet(context);
// }

// Future timestamp(BuildContext context) {
//   return checktime(context);
// }

// bool isNumeric(String s) {
//   return double.tryParse(s) != null;
// }
// String encryptAES(String plainText) {
//   if (plainText.isEmpty) {
//     return "";
//   }
//   final key = encryption.Key.fromUtf8('1#qw34?r5tgvfdcx>Az678u!jnbg&Klp');
//   final iv = encryption.IV.fromLength(16);
//   final encrypter = encryption.Encrypter(
//       encryption.AES(key, mode: encryption.AESMode.ctr, padding: null));
//   final encrypted = encrypter.encrypt(plainText, iv: iv);

//   return encrypted.base64;
// }

// String decryptAES(String ciphertext) {
//   if (ciphertext.isEmpty) {
//     return "";
//   }
//   final key = encryption.Key.fromUtf8('1#qw34?r5tgvfdcx>Az678u!jnbg&Klp');
//   final iv = encryption.IV.fromLength(16);
//   final decrypter = encryption.Encrypter(
//       encryption.AES(key, mode: encryption.AESMode.ctr, padding: null));
//   final decrypted = decrypter
//       .decryptBytes(encryption.Encrypted.fromBase64(ciphertext), iv: iv);
//   final decryptedData = utf8.decode(decrypted);

//   return decryptedData.toString();
// }

// //// get date form user with the specific format
// Future<String> getDate(BuildContext context) async {
//   DateTime selectedDate = DateTime.now();

//   final picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(1950, 8),
//       lastDate: DateTime(2025));
//   if (picked != null && picked != selectedDate) {
//     selectedDate = picked;
//   } else {
//     return "";
//   }
//   String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//   return formattedDate;
// }

// //// get time form user with the specific format
// Future<String> getTime(BuildContext context) async {
//   final TimeOfDay selectedTime;

//   final picked = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay(hour: 00, minute: 00),
//   );
//   if (picked != null) {
//     selectedTime = picked;
//   } else {
//     return "";
//   }

//   return selectedTime.format(context);
// }

// //// get time form user with only 15 minute intervals
// Future<String> getTimewithInterval(BuildContext context) async {
//   final TimeOfDay selectedTime;

//   final picked = await showIntervalTimePicker(
//     context: context,
//     initialTime: TimeOfDay(hour: 00, minute: 00),
//     interval: 15,
//     visibleStep: VisibleStep.fifteenths,
//   );

//   if (picked != null) {
//     selectedTime = picked;
//   } else {
//     return "";
//   }

//   return selectedTime.format(context);
// }

// String getYear() {
//   DateTime selectedDate = DateTime.now();

//   String formattedDate = DateFormat('yyyy').format(selectedDate);
//   return formattedDate;
// }



// DateTime timestampToDateTime(String timestamps) {
//   return DateTime.parse(timestamps);
// }

// DateTime toDateTime(String dataeTime) {
//   DateTime parsedDate = DateTime.parse(dataeTime);

//   return parsedDate;
// }

// //// here we generate a string with passed time from a given date
// String timeAgo(DateTime date) {
//   String r = "";

//   DateTime now = DateTime.now();
//   final diff = now.difference(date).inDays;
//   if (diff == 0) {
//     r = date.hour.toString() + ":" + date.minute.toString();
//   } else if (diff == 1) {
//     r = 'Yestrday ' + date.hour.toString() + ":" + date.minute.toString();
//   } else if (diff > 1 && diff < 7) {
//     r = DateFormat('EEEE').format(date) +
//         " " +
//         date.hour.toString() +
//         ":" +
//         date.minute.toString();
//   } else {
//     r = date.toString();
//   }
//   return r;
//   //  time;
// }

// //// here we generate a string with passed time from a given timestamp
// String timeStampAgo(String timestamps) {
//   String r = "";
//   DateTime date = DateTime.parse(timestamps);
//   DateTime now = DateTime.now();
//   final diff = now.difference(date).inDays;
//   if (diff == 0) {
//     r = date.hour.toString() + ":" + date.minute.toString();
//   } else if (diff == 1) {
//     r = 'Yestrday ' + date.hour.toString() + ":" + date.minute.toString();
//   } else if (diff > 1 && diff < 7) {
//     r = DateFormat('EEEE').format(date) +
//         " " +
//         date.hour.toString() +
//         ":" +
//         date.minute.toString();
//   } else {
//     r = timestamps;
//   }
//   return r;
//   //  time;
// }

// String getFileName(String path) {
//   List<String> p = path.split("/");
//   return p.last;
// }

// String getFileExtension(String path) {
//   List<String> p = path.split("/");
//   String filename = p.last;

//   return (filename.split('.').last);
// }

// Future<bool> isFileExsist(String path) async {
//   File ffile = File(path);
//   return ffile.existsSync();
// }

// bool isEmail(String email) {
//   return RegExp(
//           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//       .hasMatch(email);
// }

// bool isPhone(String value) {
//   String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//   RegExp regExp = RegExp(patttern);

//   return regExp.hasMatch(value);
// }

// bool isStrongPassowrd(String value) {
//   RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

//   return regex.hasMatch(value);
// }

/// #Local Dataa

// import 'package:shared_preferences/shared_preferences.dart';

// ///// The following methods are used to manage all types of shared preferences
// Future<String> getStringPrefs(String key) async {
//   String retrive = "";
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   retrive = (prefs.getString(key) ?? "");
//   return retrive;
// }

// Future<int> getIntPrefs(String key) async {
//   int retrive = 0;
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   retrive = (prefs.getInt(key) ?? 0);
//   return retrive;
// }

// Future<bool> getBoolPrefs(String key) async {
//   bool retrive = false;
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   retrive = (prefs.getBool(key) ?? false);
//   return retrive;
// }

// Future<double> getDoublePrefs(String key) async {
//   double retrive = 0;
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   retrive = (prefs.getDouble(key) ?? 0);
//   return retrive;
// }

// Future<List<String>> getStringListPrefs(String key) async {
//   List<String> retrive = [];
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   retrive = (prefs.getStringList(key) ?? []);
//   return retrive;
// }

// setStringPrefs(String key, String value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString(key, value);
// }

// setIntPrefs(String key, int value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setInt(key, value);
// }

// setBoolPrefs(String key, bool value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool(key, value);
// }

// setDoublePrefs(String key, double value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setDouble(key, value);
// }

// setStringListPrefs(String key, List<String> value) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setStringList(key, value);
// }

// clearPrifrences() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.clear();
// }
