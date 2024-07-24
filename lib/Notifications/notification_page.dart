import 'package:dllylas/home/DetailsPage.dart';

import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Home/all_item.dart';

import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/item_categories.dart';
import '../Landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class NotificationPage extends StatefulWidget {
  int notID = 0;
  NotificationPage({this.notID = 0, Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
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
                              // icon and text
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
                                    "Hello Every one whatsUp",
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontSize: 12,
                                        fontFamily: mainFontbold),
                                  ),
                                ],
                              ),

                              // text now
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
                          // text description
                          Text(
                            maxLines: 2,
                            "To finish setting up your Microsoft account,To finish setting up your Microsoft account,  ",
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
                      "You dont have any notification".tr,
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
                                  // icon and text
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
                                      Text(
                                        maxLines: 1,
                                        notification.title!,
                                        style: TextStyle(
                                            color: mainColorGrey,
                                            fontSize: 12,
                                            fontFamily: mainFontbold),
                                      ),
                                    ],
                                  ),

                                  // text now
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
                              // text description
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

  String timeAgo(String datetime) {
    bool numericDates = false;
    final date2 = DateTime.now();
    DateTime date = DateTime.parse(datetime);
    final difference = date2.difference(date);
    // check text bawar
    if ((difference.inDays / 7).floor() > 1) {
      return datetime.substring(0, 10);
    } else if ((difference.inDays / 7).floor() == 1) {
      return 'Last week'.tr;
    } else if (difference.inDays >= 2) {
      return '${difference.inDays}' + 'days ago'.tr;
    } else if (difference.inDays >= 1) {
      return 'Yesterday'.tr;
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}' + 'hours ago'.tr;
    } else if (difference.inHours >= 1) {
      return '1 hour ago'.tr;
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}' + 'minutes ago'.tr;
    } else if (difference.inMinutes >= 1) {
      return '1 minute ago'.tr;
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}' + 'seconds ago'.tr;
    } else {
      return 'Just now'.tr;
    }
  }
}
