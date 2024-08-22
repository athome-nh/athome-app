// Import necessary packages and libraries
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// This class represents the notification page of the app.
/// It is a StatefulWidget that takes in a notification ID [notID].
class NotificationPage extends StatefulWidget {
  int notID = 0;
  
  /// Constructor for NotificationPage. It initializes [notID].
  NotificationPage({this.notID = 0, Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

/// The state class for NotificationPage.
class _NotificationPageState extends State<NotificationPage> {
  
  /// Initializes the state of the NotificationPage.
  @override
  void initState() {
    super.initState();
  }

  /// Builds the UI of the NotificationPage.
  @override
  Widget build(BuildContext context) {
    // Get the product provider from the context.
    final productrovider = Provider.of<productProvider>(context, listen: true);

    // Filter the notifications to exclude 'chat' type notifications.
    final filteredNotifications = productrovider.Notfication.where(
        (notification) => notification.type != 'chat').toList();

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notification".tr,
            style: TextStyle(
              fontFamily: mainFontnormal,
            ),
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
        body: Visibility(
          visible: productrovider.show,
          
          /// Skeleton loading effect when notifications are not ready to display.
          replacement: Skeletonizer(
            effect: ShimmerEffect.raw(colors: [
              mainColorGrey.withOpacity(0.1),
              mainColorWhite,
            ]),
            enabled: true,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: getHeight(context, 13),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: mainColorGrey2.withOpacity(0.8),
                      ),
                      color: mainColorlightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Icon for the notification
                              Row(
                                children: [
                                  Container(
                                    width: getWidth(context, 6),
                                    height: getWidth(context, 6),
                                    decoration: BoxDecoration(
                                      color: mainColorRed,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Skeleton.keep(
                                      child: Icon(
                                        Icons.notifications,
                                        color: mainColorWhite,
                                        size: getWidth(context, 4),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getWidth(context, 2),
                                  ),
                                  Text(
                                    maxLines: 1,
                                    "Hello Everyone, what's up",
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontSize: 12,
                                        fontFamily: mainFontbold),
                                  ),
                                ],
                              ),
                              
                              /// Time indicator for the notification
                              Text(
                                "now",
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontSize: 9,
                                    fontFamily: mainFontbold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          /// Description text of the notification
                          Text(
                            maxLines: 2,
                            "To finish setting up your Microsoft account...",
                            style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 12,
                                fontFamily: mainFontnormal),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// If there are no notifications, show a default image and message.
          child: filteredNotifications.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: getHeight(context, 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: Image.asset("assets/images/notify.png"),
                      ),
                    ),
                    Text(
                      "You don't have any notification".tr,
                      style: TextStyle(
                          fontFamily: mainFontnormal,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: filteredNotifications.length,
                  itemBuilder: (context, index) {
                    final notification = filteredNotifications[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: getHeight(context, 13),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: mainColorGrey2.withOpacity(0.8),
                          ),
                          color: mainColorlightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Icon and title of the notification
                                  Row(
                                    children: [
                                      Container(
                                        width: getWidth(context, 6),
                                        height: getWidth(context, 6),
                                        decoration: BoxDecoration(
                                          color: mainColorRed,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Icon(
                                          Icons.notifications,
                                          color: mainColorWhite,
                                          size: getWidth(context, 4),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getWidth(context, 2),
                                      ),
                                      Container(
                                        width: getWidth(context, 63),
                                        child: Text(
                                          maxLines: 1,
                                          notification.title!,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontSize: 12,
                                              fontFamily: mainFontbold),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// Time when the notification was created.
                                  Text(
                                    timeAgo(notification.createdAt!),
                                    style: TextStyle(
                                        color: mainColorBlack,
                                        fontSize: 9,
                                        fontFamily: mainFontbold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /// Content/description of the notification
                              Text(
                                maxLines: 2,
                                notification.content!,
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontSize: 12,
                                    fontFamily: mainFontnormal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  /// This method calculates the time difference between the current time and the provided [datetime].
  /// It returns a human-readable string like 'Just now', '1 hour ago', or 'Last week'.
  String timeAgo(String datetime) {
    bool numericDates = false;
    final date2 = DateTime.now();
    DateTime date = DateTime.parse(datetime);
    final difference = date2.difference(date);

    // Return formatted string based on the time difference.
    if ((difference.inDays / 7).floor() > 1) {
      return datetime.substring(0, 10);
    } else if ((difference.inDays / 7).floor() == 1) {
      return 'Last week'.tr;
    } else if (difference.inDays >= 2) {
      return '${difference.inDays}' + ' days ago'.tr;
    } else if (difference.inDays >= 1) {
      return 'Yesterday'.tr;
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}' + ' hours ago'.tr;
    } else if (difference.inHours >= 1) {
      return '1 hour ago'.tr;
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}' + ' minutes ago'.tr;
    } else if (difference.inMinutes >= 1) {
      return '1 minute ago'.tr;
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}' + ' seconds ago'.tr;
    } else {
      return 'Just now'.tr;
    }
  }
}
