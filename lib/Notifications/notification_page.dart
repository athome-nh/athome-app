import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Home/all_item.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/home/oneitem.dart';
import 'package:dllylas/home/track_order.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/order_model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationPage extends StatefulWidget {
  int notID = 0;
  NotificationPage({this.notID = 0, Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NavSwitch()),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
        body: Visibility(
          visible: productrovider.show,
          replacement: Skeletonizer(
            enabled: true,
            child: ListView.builder(
              itemCount: productrovider.Notfication.length,
              itemBuilder: (context, index) {
                final notification = productrovider.Notfication[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.all(8),
                  color: mainColorWhite,
                  child: Column(
                    children: <Widget>[
                      Badge(
                        label: widget.notID == notification.id
                            ? Text("New".tr)
                            : SizedBox(),
                        alignment: Alignment.topLeft,
                        backgroundColor: widget.notID == notification.id
                            ? mainColorRed
                            : Colors.transparent,
                        largeSize: 20,
                        textStyle: TextStyle(
                            fontFamily: mainFontnormal,
                            fontSize: 8,
                            color: mainColorRed),
                        child: ListTile(
                          onTap: () {
                            if ('onItem' == notification.type) {
                              productrovider.setidItem(productrovider
                                  .getoneProductByBarcode(
                                      notification.subrelation!)
                                  .id!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Oneitem()),
                              );
                            } else if ('discount' == notification.type) {
                              productrovider.settype("discount");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllItem()),
                              );
                            } else if ('brand' == notification.type) {
                              productrovider.settype("brand");
                              productrovider
                                  .setidbrand(notification.relationId!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllItem()),
                              );
                            } else if ('category' == notification.type) {
                              if (productrovider.categores.indexWhere(
                                      (category) =>
                                          category.id ==
                                          notification.relationId!) ==
                                  -1) {
                                return;
                              }
                              productrovider
                                  .setcatetype(notification.relationId!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => itemCategories()),
                              ).then((value) {
                                productrovider.setsubcateSelect(0);
                              });
                            } else if ('subcategory' == notification.type) {
                              if (productrovider.categores.indexWhere(
                                          (category) =>
                                              category.id ==
                                              notification.relationId!) ==
                                      -1 ||
                                  productrovider.subCategores.indexWhere(
                                          (subCategory) =>
                                              subCategory.id ==
                                              int.parse(
                                                  notification.subrelation!)) ==
                                      -1) {
                                return;
                              }
                              productrovider
                                  .setcatetype(notification.relationId!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => itemCategories(
                                          subcateID: int.parse(
                                              notification.subrelation!),
                                        )),
                              ).then((value) {
                                productrovider.setsubcateSelect(0);
                              });
                            } else if ('order' == notification.type) {
                            } else if ('attention' == notification.type) {}
                          },
                          leading: Icon(
                            Ionicons.notifications_outline,
                            color: mainColorRed,
                            size: 35,
                          ),
                          title: Text(
                            notification.title!,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontSize: 16,
                                fontFamily: mainFontbold),
                          ),
                          subtitle: Text(
                            notification.content!,
                            style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 12,
                                fontFamily: mainFontnormal),
                          ),
                          trailing: Text(
                            timeAgo(notification.createdAt!),
                            style: TextStyle(
                                color: mainColorGrey,
                                fontSize: 12,
                                fontFamily: mainFontbold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          child: productrovider.Notfication.isEmpty
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
                  itemCount: productrovider.Notfication.length,
                  itemBuilder: (context, index) {
                    final notification = productrovider.Notfication[index];
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.all(8),
                      color: mainColorWhite,
                      child: Column(
                        children: <Widget>[
                          Badge(
                            label: widget.notID == notification.id
                                ? Text("New".tr)
                                : SizedBox(),
                            alignment: Alignment.topLeft,
                            backgroundColor: widget.notID == notification.id
                                ? mainColorRed
                                : Colors.transparent,
                            largeSize: 20,
                            textStyle: TextStyle(
                                fontFamily: mainFontnormal,
                                fontSize: 8,
                                color: mainColorRed),
                            child: ListTile(
                              onTap: () {
                                if ('onItem' == notification.type) {
                                  productrovider.setidItem(productrovider
                                      .getoneProductByBarcode(
                                          notification.subrelation!)
                                      .id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Oneitem()),
                                  );
                                } else if ('discount' == notification.type) {
                                  productrovider.settype("discount");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AllItem()),
                                  );
                                } else if ('brand' == notification.type) {
                                  productrovider.settype("brand");
                                  productrovider
                                      .setidbrand(notification.relationId!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AllItem()),
                                  );
                                } else if ('category' == notification.type) {
                                  if (productrovider.categores.indexWhere(
                                          (category) =>
                                              category.id ==
                                              notification.relationId!) ==
                                      -1) {
                                    return;
                                  }
                                  productrovider
                                      .setcatetype(notification.relationId!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => itemCategories()),
                                  ).then((value) {
                                    productrovider.setsubcateSelect(0);
                                  });
                                } else if ('subcategory' == notification.type) {
                                  if (productrovider.categores.indexWhere(
                                              (category) =>
                                                  category.id ==
                                                  notification.relationId!) ==
                                          -1 ||
                                      productrovider.subCategores.indexWhere(
                                              (subCategory) =>
                                                  subCategory.id ==
                                                  int.parse(notification
                                                      .subrelation!)) ==
                                          -1) {
                                    return;
                                  }
                                  productrovider
                                      .setcatetype(notification.relationId!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => itemCategories(
                                              subcateID: int.parse(
                                                  notification.subrelation!),
                                            )),
                                  ).then((value) {
                                    productrovider.setsubcateSelect(0);
                                  });
                                } else if ('order' == notification.type) {
                                  OrderModel order =
                                      productrovider.Orders.firstWhere(
                                          (element) =>
                                              element.id ==
                                              notification.relationId!);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => TrackOrder(
                                            order.id.toString(),
                                            order.returnTotalPrice.toString(),
                                            order.createdAt.toString())),
                                  );
                                } else if ('attention' == notification.type) {}
                              },
                              leading: Icon(
                                Ionicons.notifications_outline,
                                color: mainColorRed,
                                size: 35,
                              ),
                              title: Text(
                                textCount(notification.title!, 35),
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontSize: 14,
                                    fontFamily: mainFontbold),
                              ),
                              subtitle: Text(
                                textCount(notification.content!, 70),
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontSize: 12,
                                    fontFamily: mainFontnormal),
                              ),
                              trailing: Text(
                                timeAgo(notification.createdAt!),
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontSize: 9,
                                    fontFamily: mainFontbold),
                              ),
                            ),
                          ),
                        ],
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
    if ((difference.inDays / 7).floor() >= 1) {
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
