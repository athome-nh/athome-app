import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;
  RetryOnConnectionChangeInterceptor({
    @required required this.requestRetrier,
  });

  @override
  Future onError(DioException err, handler) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        // Let any new error from the retrier pass through
        return e;
      }
    }
    // Let the error pass through if it's not the error we're looking for
    return err;
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioException &&
        err.error != null &&
        err.error is SocketException;
  }
}
