import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dio_connectivity_request_retrier.dart';

/// A Dio interceptor that retries requests when there is a connection change.
/// It retries the failed requests due to network issues, such as connection loss.
class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  /// Constructor for RetryOnConnectionChangeInterceptor.
  /// Requires a [requestRetrier] to handle scheduling of retries.
  RetryOnConnectionChangeInterceptor({
    @required required this.requestRetrier,
  });

  /// Intercepts the error responses and checks if a retry should be attempted.
  /// If the error is caused by network-related issues, it schedules a retry.
  @override
  Future onError(DioException err, handler) async {
    // Check if the error qualifies for a retry
    if (_shouldRetry(err)) {
      try {
        // If retry should happen, schedule the request retry through the retrier
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        // Return the caught exception if retry scheduling fails
        return e;
      }
    }
    // If no retry should happen, return the error
    return err;
  }

  /// Checks whether the error is retryable.
  /// The method will retry if the error type is related to network (SocketException).
  bool _shouldRetry(DioException err) {
    // Return true if the error is a network-related error (SocketException)
    return err.type == DioException &&  // Checking if error type is DioException
        err.error != null &&            // Ensure the error is not null
        err.error is SocketException;   // Check if the error is due to a SocketException (network issue)
  }
}
