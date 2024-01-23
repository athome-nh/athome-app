// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static NotificationController get instance => NotificationController();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future takeFCMTokenWhenAppLaunch() async {
    try {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //   saveUerTokenToSharedPreference();
      //   // ignore: avoid_print
      // } else if (settings.authorizationStatus ==
      //     AuthorizationStatus.provisional) {
      //   saveUerTokenToSharedPreference();
      //   // ignore: avoid_print
      // } else {
      //   // ignore: avoid_print
      // }
    } catch (e) {
      //
    }
  }

  Future<void> saveUerTokenToSharedPreference() async {
    _firebaseMessaging.getToken().then((val) async {});
  }

  Future initLocalNotification() async {
    if (Platform.isIOS) {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('app_icon');
      var initializationSettingsIOS = const DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,

        requestAlertPermission: true,
        //onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        //  onSelectNotification: _selectNotification
      );
    } else {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('icon_notification');
      var initializationSettingsIOS = const DarwinInitializationSettings(
        //  onDidReceiveLocalNotification: _onDidReceiveLocalNotification
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        //  onSelectNotification: _selectNotification
      );
    }
  }

  // ignore: unused_element
  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  // ignore: unused_element
  Future _selectNotification(String payload) async {}
}
