import 'dart:async';

import 'package:DllyLas/Config/my_widget.dart';
import 'package:DllyLas/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Network.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          streamSubscription.cancel();
          responseCompleter.complete(
            dio.post(requestOptions.path, data: requestOptions.data),
          );
          noInertnetShowed = false;
          ScaffoldMessenger.of(navigatorKey.currentContext!)
              .showSnackBar(internetBackSnackBar)
              .closed
              .then((value) =>
                  ScaffoldMessenger.of(navigatorKey.currentContext!)
                      .clearSnackBars());
        }
      },
    );

    return responseCompleter.future;
  }
}
