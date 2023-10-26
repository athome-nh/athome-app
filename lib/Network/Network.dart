// ignore_for_file: empty_catches, file_names

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
  String token = "";
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
    try {
      dio.options.headers["Authorization"] = "Bearer " + token;
      Response response = await dio.get(serverUrl + apiRout);
      return response.data;
    } catch (e) {
      return "";
    }
  }

  Future getData(String apiRout) async {
    try {
      Response response = await dio.get(serverUrl + apiRout);
      return response.data;
    } catch (e) {
      return "";
    }
  }

  Future<bool> addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = serverUrl + "profileImg";
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
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
  }

  Future getDataAll(String apiRout, BuildContext context) async {
    try {
      Response response = await dio.get(
        serverUrl + apiRout,
      );

      return response.data;
    } catch (e) {
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
  }

  Future postData(String rout, Map data, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      try {
        Response response = await dio.post(
          serverUrl + rout,
          data: data,
        );
        print(response.statusCode);
        return response.data;
      } catch (e) {
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
    } else {
      if (!onbaord && !noInertnetShowed) {
        noInertnetShowed = true;
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(noInternetSnackBar)
            .closed
            .then((value) => ScaffoldMessenger.of(navigatorKey.currentContext!)
                .clearSnackBars());
      }

      Response response = await retrier.scheduleRequestRetry(RequestOptions(
        path: serverUrl + rout,
        data: data,
      ));
      return response.data;
    }
  }
}
