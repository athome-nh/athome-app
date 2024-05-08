import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Home/all_item.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/home/oneitem.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
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
        itemCount: productrovider.Notfication.length,
        itemBuilder: (context, index) {
          final notification = productrovider.Notfication[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.all(8),
            color: mainColorWhite,
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    if ('onItem' == notification.type) {
                      productrovider.setidItem(productrovider
                          .getoneProductByBarcode(notification.barcode!)
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
                      productrovider.setidbrand(notification.relationId!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllItem()),
                      );
                    } else if ('category' == notification.type) {
                      if (productrovider.categores.indexWhere((category) =>
                              category.id == notification.relationId!) ==
                          -1) {
                        return;
                      }
                      productrovider.setcatetype(notification.relationId!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => itemCategories()),
                      ).then((value) {
                        productrovider.setsubcateSelect(0);
                      });
                    } else if ('subcategory' == notification.type) {
                      if (productrovider.categores.indexWhere((category) =>
                                  category.id == notification.relationId!) ==
                              -1 ||
                          productrovider.subCategores.indexWhere(
                                  (subCategory) =>
                                      subCategory.id ==
                                      int.parse(notification.barcode!)) ==
                              -1) {
                        return;
                      }
                      productrovider.setcatetype(notification.relationId!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => itemCategories(
                                  subcateID: int.parse(notification.barcode!),
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
              ],
            ),
          );
        },
      ),
    );
  }

  String timeAgo(String datetime) {
    bool numericDates = false;
    final date2 = DateTime.now();
    DateTime date = DateTime.parse(datetime);
    final difference = date2.difference(date);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
