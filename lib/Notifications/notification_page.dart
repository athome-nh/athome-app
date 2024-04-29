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
      title: 'Notification 1',
      description: 'This is the first notification.',
      date: '2024-04-29',
    ),
    NotificationItem(
      icon: Icons.notifications,
      title: 'Notification 2',
      description: 'This is the second notification.',
      date: '2024-04-28',
    ),
    NotificationItem(
      icon: Icons.notifications,
      title: 'Notification 3',
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
          return Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Ionicons.notifications_outline,
                  color: mainColorGrey,
                  size: 35,
                ),
                title: Text(
                  notification.title,
                  style: TextStyle(
                      color: mainColorBlack,
                      fontSize: 22,
                      fontFamily: mainFontnormal),
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
                      color: mainColorBlack,
                      fontSize: 12,
                      fontFamily: mainFontnormal),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              ),
            ],
          );
        },
      ),
    );
  }
}
