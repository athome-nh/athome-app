import 'package:flutter/material.dart';

import 'package:athome/Config/property.dart';

class NotficationScreen extends StatefulWidget {
  const NotficationScreen({super.key});

  @override
  State<NotficationScreen> createState() => _NotficationScreenState();
}

class _NotficationScreenState extends State<NotficationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Notfication",
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
        child: Container(
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
                                      'New Discount',
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
                                        'Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order',
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
                    child: Container(
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
                              "You orders has been picked up",
                              style: TextStyle(
                                  color: mainColorGrey,
                                  fontFamily: mainFontnormal,
                                  fontSize: 14),
                            ),
                            subtitle: Text(
                              "Now",
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
    );
  }
}
