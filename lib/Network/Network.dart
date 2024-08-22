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

bool noInertnetShowed = false;

/// [Network] class is used to handle network requests in the app. 
/// It supports token-based authentication, retries on connection changes, and data encryption for secure communication.
class Network {
  bool onbaord;
  var dio = Dio();
  late DioConnectivityRequestRetrier retrier;

  /// Constructor for initializing the [Network] class with onboarding state.
  /// Sets the necessary headers for JSON requests and initializes the [DioConnectivityRequestRetrier] for retrying requests on connection issues.
  Network(this.onbaord) {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] =
        "Bearer \$2y\$10\$cWpEHfA758.m1nKE0zdZP.5gFJZKE9pIF1/1jUv5AV69XeWPX4E76";
    retrier =
        DioConnectivityRequestRetrier(dio: dio, connectivity: Connectivity());
  }

  /// Fetches user data from the API using a specific route and token.
  /// Encrypts a token generated from the server's current time and uses it for additional security.
  Future getDatauser(String apiRout, String token) async {
    Map<String, dynamic> data = {};
    try {
      if (token.isNotEmpty) {
        await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
          // Setting headers for authorization and aToken
          dio.options.headers["Authorization"] = "Bearer " + token;
          dio.options.headers["aToken"] =
              encryptAES(generateRandomText(time.data["data"]));

          // Fetch data from the API
          Response response = await dio.get(dotenv.env['serverUrl']! + apiRout);
          data = response.data;
        });
      } else {
        // Display error message when the token is missing
        toastLong(
          'An error occurred, Please try again later.'.tr,
        );
      }
    } catch (e) {
      // Return empty data in case of any exceptions
      return "";
    }
    return data;
  }

  /// Fetches data from the API using a specific route without a token.
  /// Also retrieves the server time to generate a security token for the request.
  Future getData(String apiRout) async {
    Map<String, dynamic> data = {};
    try {
      await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
        datetimeS = DateTime.parse(time.data["data"]);
        
        // Set headers with the security token and authorization
        dio.options.headers["Authorization"] = "Bearer " + token;
        dio.options.headers["aToken"] =
            encryptAES(generateRandomText(time.data["data"]));

        // Fetch data from the API
        Response response = await dio.get(dotenv.env['serverUrl']! + apiRout);
        data = response.data;
      });
    } catch (e) {
      print(e);
      return "";
    }
    return data;
  }

  /// Fetches location data from a provided URL.
  /// This method handles location-related requests.
  Future locationname(String url) async {
    try {
      Response response = await dio.get(url);
      return response.data;
    } catch (e) {
      return "";
    }
  }

  /// Adds an image to the server by uploading it through a multipart POST request.
  /// The request includes form data, headers for authentication, and the image file itself.
  Future addImage(
      String route, Map<String, String> body, String filepath) async {
    String addimageUrl = dotenv.env['serverUrl']! + route;

    try {
      await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
        // Set headers for the multipart request
        Map<String, String> headers = {
          'Content-Type': 'multipart/form-data',
          'Authorization': "Bearer " + token,
          'aToken': encryptAES(generateRandomText(time.data["data"])),
        };

        // Prepare and send the multipart request with the image
        var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
          ..fields.addAll(body)
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath('img', filepath));

        var response = await request.send();

        // Handle the response status code
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

  /// Sends a POST request with the provided data to the specified route.
  /// Handles user authentication, retrieves server time for token generation, and sends the data to the server.
  Future postData(String rout, Map data, BuildContext context) async {
    Map<String, dynamic> data2 = {};
    try {
      if (isLogin) {
        // Set headers for logged-in users
        await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
          datetimeS = DateTime.parse(time.data["data"]);
          dio.options.headers["Authorization"] = "Bearer " + token;
          dio.options.headers["aToken"] =
              encryptAES(generateRandomText(time.data["data"]));

          // Send POST request with the provided data
          Response response = await dio.post(
            dotenv.env['serverUrl']! + rout,
            data: data,
          );
          data2 = response.data;
        });
      } else {
        // Set headers for guests
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
      // Display a snackbar if an error occurs
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

  /// Updates user data on the server by sending a POST request with authentication.
  /// This method is similar to [postData] but requires a user token for authorization.
  Future updateUserTemp(
      String rout, Map data, BuildContext context, String User_token) async {
    Map<String, dynamic> data2 = {};
    try {
      await dio.get(dotenv.env['serverUrl']! + "time").then((time) async {
        datetimeS = DateTime.parse(time.data["data"]);

        // Set headers with the user token and security token
        dio.options.headers["Authorization"] =
            "Bearer " + decryptAES(User_token);
        dio.options.headers["aToken"] =
            encryptAES(generateRandomText(time.data["data"]));

        // Send POST request with the updated user data
        Response response = await dio.post(
          dotenv.env['serverUrl']! + rout,
          data: data,
        );
        data2 = response.data;
      });
    } catch (e) {
      // Display a snackbar if an error occurs
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
