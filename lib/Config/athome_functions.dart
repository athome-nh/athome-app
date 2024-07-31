import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/product_model/product_model.dart';

import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encryption;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:path_provider/path_provider.dart';

//// a fast way to push to a new screen
void to(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

String generateRandomText(String time) {
  DateTime d = DateTime.parse(time);

  String code_2 = (d.millisecondsSinceEpoch).toString();
  final _random = Random();

  final RegExp regex = RegExp(r'^[a-zA-Z0-9!@#\$%^&*,.?":]{64}$');
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*(),.?:';
  final length = 64; // Adjust the length to match your regex pattern

  String randomText;
  do {
    randomText = String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(_random.nextInt(characters.length)),
    ));
  } while (!regex.hasMatch(randomText));
  //String code_2 = DateTime.now().millisecondsSinceEpoch.toString();

  return code_3(code_2, randomText);
}

String code_3(String code_2, String randomText) {
  List<String> charactersArray = randomText.split('');
  List<String> charactersArray2 = code_2.split('');

  List<int> listOfNum = (dotenv.env['tokenkey']?.split(',') ?? [])
      .map((value) => int.tryParse(value) ?? 0)
      .toList();

  for (int i = 0; i < 13; i++) {
    charactersArray[listOfNum[i]] = charactersArray2[i];
  }

  String result = charactersArray.join('');

  return result;
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

bool checkOferPrice(ProductModel product) {
  return product.endOffer != "none" &&
      datetimeS.isBefore(DateTime.parse(product.endOffer.toString()));
}

bool checkProductStock(ProductModel product, int i) {
  i = i + 5;
  return product.stock == i;
}

bool checkProductLimit(ProductModel product, int i) {
  return checkOferPrice(product) && product.orderLimit == i;
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
  final key = encryption.Key.fromUtf8(dotenv.env["encryptionkey"]!);
  final iv = encryption.IV.fromUtf8("0000000000000000");

  final encrypter =
      encryption.Encrypter(encryption.AES(key, mode: encryption.AESMode.cbc));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}

String decryptAES(String ciphertext) {
  if (ciphertext.isEmpty) {
    return "";
  }
  final key = encryption.Key.fromUtf8(dotenv.env["encryptionkey"]!);
  final iv = encryption.IV.fromUtf8("0000000000000000");
  final encrypter =
      encryption.Encrypter(encryption.AES(key, mode: encryption.AESMode.cbc));

  final decryptedBytes =
      encrypter.decrypt(encryption.Encrypted.fromBase64(ciphertext), iv: iv);

  //final decryptedText = utf8.decode(decryptedBytes);

  return decryptedBytes.toString();
}

Future<int> getOnlineTimestamp() async {
  DateTime startDate = await NTP.now();
  return startDate.hour;
}

Future<String> getServerTime() async {
  String startDate = await NTP.now().toString();
  try {
    var dio = Dio();
    await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
      startDate = time.data["data"];
    });
    return startDate;
  } catch (e) {
    return startDate;
  }
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

String addCommasToPriceWithoutIQD(int price) {
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
    return integerWithCommas;
  } else {
    return '$integerWithCommas.${parts[1]}';
  }
}

String convertToBaghdadTime(String utcTimeString) {
  // Parse the UTC time string
  DateTime utcDateTime = DateTime.parse(utcTimeString);

  // Define the Baghdad timezone
  String baghdadTimeZone = 'Asia/Baghdad';

  // Get the current time zone offset for Baghdad
  var baghdadTimeZoneOffset = Duration(hours: 3); // Baghdad is UTC+3

  // Apply the time zone offset to the UTC time
  DateTime baghdadDateTime = utcDateTime.add(baghdadTimeZoneOffset);

  // Format the datetime in a human-readable format
  DateFormat formatter =
      lang == "en" ? DateFormat('MMM/dd-HH:mm') : DateFormat('MM/dd-HH:mm');
  return formatter.format(baghdadDateTime);
}

String calculatePercentageDiscount(
    double originalPrice, double discountedPrice) {
  if (originalPrice <= 0 ||
      discountedPrice <= 0 ||
      originalPrice <= discountedPrice) {
    return 'Off'; // Handle invalid or zero values, or when the original price is less than or equal to the discounted price.
  }

  double discountAmount = originalPrice - discountedPrice;
  double percentageDiscount = (discountAmount / originalPrice) * 100;

  return '${percentageDiscount.toStringAsFixed(0)}%';
}

String fontBoldChoose() {
  String font = lang == "en"
      ? lang == "ar"
          ? ""
          : ""
      : "";
  return font;
}

String fontNormalChoose() {
  String font = lang == "en"
      ? lang == "ar"
          ? ""
          : ""
      : "";
  return font;
}
