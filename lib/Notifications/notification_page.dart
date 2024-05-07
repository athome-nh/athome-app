import 'package:dllylas/Config/property.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class NotificationItem {
  final IconData icon;
  final String title;
  final String description;
  final String date;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
  });
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: Icons.notifications,
      title: 'Title 1',
      description: 'This is the first notification.',
      date: '2024-04-29',
    ),
    NotificationItem(
      icon: Icons.notifications,
      title: 'Title 2',
      description: 'This is the second notification.',
      date: '2024-04-28',
    ),
    NotificationItem(
      icon: Icons.notifications,
      title: 'Title 3',
      description: 'This is the third notification.',
      date: '2024-04-27',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification".tr,
          style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),

        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.all(8),
            color: mainColorWhite,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Ionicons.notifications_outline,
                    color: mainColorRed,
                    size: 35,
                  ),
                  title: Text(
                    notification.title,
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 16,
                        fontFamily: mainFontbold),
                  ),
                  subtitle: Text(
                    notification.description,
                    style: TextStyle(
                        color: mainColorBlack,
                        fontSize: 12,
                        fontFamily: mainFontnormal),
                  ),
                  trailing: Text(
                    notification.date,
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 12,
                        fontFamily: mainFontbold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
