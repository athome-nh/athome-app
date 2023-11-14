// ignore_for_file: empty_catches, file_names

import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
        await dio.get(serverUrl + "time").then((time) async {
          dio.options.headers["Authorization"] = "Bearer " + token;
          dio.options.headers["aToken"] = generateRandomText(time.data["data"]);
          Response response = await dio.get(serverUrl + apiRout);
          data = response.data;
        });
      } else {
        toastLong('An error occured, Please try again.');
      }
    } catch (e) {
      return "";
    }
    return data;
  }

  Future getData(String apiRout) async {
    Map<String, dynamic> data = {};
    try {
      await dio.get(serverUrl + "time").then((time) async {
        datetimeS = DateTime.parse(time.data["data"]);
        dio.options.headers["Authorization"] = "Bearer " + token;

        dio.options.headers["aToken"] = generateRandomText(time.data["data"]);

        Response response = await dio.get(serverUrl + apiRout);

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
    String addimageUrl = serverUrl + "profileImg";
    try {
      await dio.get(serverUrl + "time").then((time) async {
        Map<String, String> headers = {
          'Content-Type': 'multipart/form-data',
          'Authorization': "Bearer " + token,
          'aToken': generateRandomText(time.data["data"]),
        };
        var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
          ..fields.addAll(body)
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath('img', filepath));

        var response = await request.send();

        if (response.statusCode == 201) {
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
        await dio.get(serverUrl + "time").then((time) async {
          datetimeS = DateTime.parse(time.data["data"]);
          dio.options.headers["Authorization"] = "Bearer " + token;
          dio.options.headers["aToken"] = generateRandomText(time.data["data"]);
          Response response = await dio.post(
            serverUrl + rout,
            data: data,
          );

          data2 = response.data;
        });
      } else {
        await dio.get(serverUrl + "time").then((time) async {
          datetimeS = DateTime.parse(time.data["data"]);
          dio.options.headers["aToken"] = generateRandomText(time.data["data"]);
          Response response = await dio.post(
            serverUrl + rout,
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
              'An error occured, Please try again.',
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
