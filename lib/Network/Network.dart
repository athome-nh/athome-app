// ignore_for_file: empty_catches, file_names

import 'dart:convert';

import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http/http.dart' as http;
import 'dio_connectivity_request_retrier.dart';

// import 'package:http/http.dart' as http;
bool noInertnetShowed = false;

class Network {
  bool onbaord;
  var dio = Dio();
  late DioConnectivityRequestRetrier retrier;

  Network(this.onbaord) {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] =
        "Bearer \$2y\$10\$cWpEHfA758.m1nKE0zdZP.5gFJZKE9pIF1/1jUv5AV69XeWPX4E76";
    retrier =
        DioConnectivityRequestRetrier(dio: dio, connectivity: Connectivity());
  }

  Future getDatauser(String apiRout, String token) async {
    Map<String, dynamic> data = {};
    try {
      if (token.isNotEmpty) {
        await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
          dio.options.headers["Authorization"] = "Bearer " + token;
          dio.options.headers["aToken"] =
              encryptAES(generateRandomText(time.data["data"]));
          Response response = await dio.get(dotenv.env['serverUrl']! + apiRout);
          data = response.data;
        });
      } else {
        toastLong(
          'An error occurred, Please try again later.'.tr,
        );
      }
    } catch (e) {
      return "";
    }
    return data;
  }

  Future getData(String apiRout) async {
    Map<String, dynamic> data = {};
    try {
      await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
        datetimeS = DateTime.parse(time.data["data"]);
        dio.options.headers["Authorization"] = "Bearer " + token;

        dio.options.headers["aToken"] =
            encryptAES(generateRandomText(time.data["data"]));

        Response response = await dio.get(dotenv.env['serverUrl']! + apiRout);

        data = response.data;
      });
    } catch (e) {
      print(e);
      return "";
    }
    return data;
  }

  Future locationname(String url) async {
    try {
      Response response = await dio.get(url);

      return response.data;
    } catch (e) {
      return "";
    }
  }

  Future addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = dotenv.env['serverUrl']! + "profileImg";

    try {
      await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
        Map<String, String> headers = {
          'Content-Type': 'multipart/form-data',
          'Authorization': "Bearer " + token,
          'aToken': encryptAES(generateRandomText(time.data["data"])),
        };

        var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
          ..fields.addAll(body)
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath('img', filepath));

        var response = await request.send();

        if (response.statusCode == 201) {
          var responseData = await http.Response.fromStream(response);
          var decodedData = json.decode(responseData.body);

          return true;
        } else {
          return false;
        }
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future postData(String rout, Map data, BuildContext context) async {
    Map<String, dynamic> data2 = {};
    try {
      if (isLogin) {
        await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
          datetimeS = DateTime.parse(time.data["data"]);
          dio.options.headers["Authorization"] = "Bearer " + token;
          dio.options.headers["aToken"] =
              encryptAES(generateRandomText(time.data["data"]));
          Response response = await dio.post(
            dotenv.env['serverUrl']! + rout,
            data: data,
          );

          data2 = response.data;
        });
      } else {
        await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
          datetimeS = DateTime.parse(time.data["data"]);
          dio.options.headers["aToken"] =
              encryptAES(generateRandomText(time.data["data"]));
          Response response = await dio.post(
            dotenv.env['serverUrl']! + rout,
            data: data,
          );

          data2 = response.data;
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            duration: const Duration(seconds: 4),
            content: Text(
              'An error occurred, Please try again later.'.tr,
              style: TextStyle(color: mainColorWhite),
            ),
            backgroundColor: mainColorGrey,
          ))
          .closed
          .then((value) => ScaffoldMessenger.of(context).clearSnackBars());

      return "";
    }
    return data2;
  }

  Future updateUserTemp(
      String rout, Map data, BuildContext context, String User_token) async {
    Map<String, dynamic> data2 = {};
    try {
      await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
        datetimeS = DateTime.parse(time.data["data"]);
        dio.options.headers["Authorization"] =
            "Bearer " + decryptAES(User_token);
        dio.options.headers["aToken"] =
            encryptAES(generateRandomText(time.data["data"]));
        Response response = await dio.post(
          dotenv.env['serverUrl']! + rout,
          data: data,
        );

        data2 = response.data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            duration: const Duration(seconds: 4),
            content: Text(
              'An error occurred, Please try again later.'.tr,
              style: TextStyle(color: mainColorWhite),
            ),
            backgroundColor: mainColorGrey,
          ))
          .closed
          .then((value) => ScaffoldMessenger.of(context).clearSnackBars());

      return "";
    }
    return data2;
  }
}
