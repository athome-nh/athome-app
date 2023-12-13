import 'package:DllyLas/main.dart';
import 'package:flutter/material.dart';
import 'package:DllyLas/Config/property.dart';
import 'package:get/get.dart';

class NotficationScreen extends StatefulWidget {
  const NotficationScreen({super.key});

  @override
  State<NotficationScreen> createState() => _NotficationScreenState();
}

class _NotficationScreenState extends State<NotficationScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            "Notfication".tr,
            style: TextStyle(
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: mainColorWhite,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),

          // Change the color of the unselected tab labels
        ),
        body: SingleChildScrollView(
          child: SizedBox(
              height: getHeight(context, 100),
              width: getWidth(context, 100),
              child: ListView.builder(
                  itemCount: 20, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              // Set the height of the bottom sheet as needed
                              height: getHeight(context, 90),
                              color: mainColorWhite,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 4)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(context, 2)),
                                      child: Text(
                                        "New Discount".tr,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: mainColorGrey,
                                            fontFamily: mainFontbold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: getHeight(context, 2),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(context, 2)),
                                      child: Text(
                                          'Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order'
                                              .tr,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: mainColorGrey,
                                            fontFamily: mainFontnormal,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: SizedBox(
                          width: getWidth(context, 100),
                          height: getHeight(context, 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.circle,
                                color: mainColorRed,
                                size: 14,
                              ),
                              title: Text(
                                "You orders has been picked up".tr,
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              ),
                              subtitle: Text(
                                "Now".tr,
                                style: TextStyle(
                                    color: mainColorGrey.withOpacity(0.5),
                                    fontFamily: mainFontnormal,
                                    fontSize: 12),
                              ),
                            ),
                          )),
                    );
                  })),
        ),
      ),
    );
  }
}
