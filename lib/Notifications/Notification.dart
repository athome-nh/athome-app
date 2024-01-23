// ignore_for_file: file_names, avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:dllylas/Config/property.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMNotification {
  BuildContext context;

  FCMNotification(this.context);

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  AudioPlayer audioPlayer = AudioPlayer();

  void playSound() async {
    try {
      // Additional configuration or setup if needed
      audioPlayer.play(AssetSource('images/dllylas.wav'));
    } catch (e) {
      print('Error initializing AudioPlayer: $e');
    }
  }

  void puaseSound() {
    audioPlayer.pause();
  }

  config() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        if (message.data["screen"] == "userBooking") {
          //userdateselect = message.data["date"];
        } else if (message.data["screen"] == "barberBooking") {
          // dateselectd = message.data["date"];
        } else if (message.data["screen"] == "permission") {
        } else if (message.data["screen"] == "live") {}
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        playSound();
        Get.snackbar(message.notification!.title.toString(),
            message.notification!.body.toString(),
            backgroundColor: mainColorWhite,
            colorText: mainColorBlack,
            duration: Duration(seconds: 5),
            forwardAnimationCurve: Curves.easeOutBack,
            icon: Icon(
              Icons.notifications_active_outlined,
              color: mainColorRed,
            ));

        // flutterLocalNotificationsPlugin.show(
        //     notification.hashCode,
        //     notification.title,
        //     notification.body,
        //     NotificationDetails(
        //       android: AndroidNotificationDetails(
        //         channel.id,
        //         channel.name,
        //         // channel.description,
        //         //      one that already exists in example app.
        //         icon: 'launch_background',
        //       ),
        //     ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data["screen"] == "userBooking") {
        // userdateselect = message.data["date"];
      } else if (message.data["screen"] == "barberBooking") {
        //  dateselectd = message.data["date"];
      } else if (message.data["screen"] == "live") {
      } else if (message.data["screen"] == "permission") {}

      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });

    // Set the background messaging handler early on, as a named top-level function

    channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        // 'This channel is used for important notifications.', // description
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound('dllylas.wav'),
        playSound: true);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

// Crude counter to make messages unique
  int _messageCount = 0;

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMPayload(String token) {
    _messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
  }

  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
        }
        break;
      case 'unsubscribe':
        {
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
          } else {}
        }
        break;
      default:
        break;
    }
  }

  Future<String> getToken() async {
    String? token = await messaging.getToken();

    return token!;
  }

  Future<void> sendNotification(
    String _token,
    String title,
    String content,
    String screen,
  ) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': dotenv.env['fcmKey']!,
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': content,
              'title': title,
              'badge': '1', //'$unReadMSGCount'
              "sound": "default",
              "default_vibrate_timings": false,
              "vibrate_timings": ["0.0s", "0.2s", "0.1s", "o.2s"],
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'screen': screen,
            },
            'to': _token,
          },
        ),
      );
    } catch (e) {}
  }

  Future<void> sendNotificationpayment(
    String _token,
    String title,
    String content,
    String screen,
    String date,
    String serv,
  ) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': dotenv.env['fcmKey']!,
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': content,
              'title': title,
              'badge': '1', //'$unReadMSGCount'
              "sound": "default",
              "default_vibrate_timings": false,
              "vibrate_timings": ["0.0s", "0.2s", "0.1s", "0.2s"],
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'screen': screen,
              "date": date,
              "serv": serv,
            },
            'to': _token,
          },
        ),
      );
    } catch (e) {}
  }
}
