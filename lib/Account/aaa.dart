import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/Order/track_order.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/// A screen that displays a success message after an order is placed.
/// It provides options to track the order, agree to out-of-range delivery,
/// or cancel the order.
class successScreen extends StatefulWidget {
  // Order details passed from the previous screen
  final String total;
  final String id;
  final String time;
  final bool outrange; // Indicates if delivery is out of range
  final bool isSchedule; // Indicates if the order is scheduled
  final String schedule; // Schedule time for the order
  final int deleverycost; // Delivery cost

  // Constructor to initialize the order details
  successScreen(
    this.total,
    this.id,
    this.time,
    this.outrange,
    this.isSchedule,
    this.schedule,
    this.deleverycost, {
    super.key,
  });

  @override
  State<successScreen> createState() => _successScreenState();
}

class _successScreenState extends State<successScreen> {
  @override
  Widget build(BuildContext context) {
    // Access the product provider to manage product-related data
    final productrovider = Provider.of<productProvider>(context, listen: true);

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Ordered successfully".tr, // Display success message
          ),
          automaticallyImplyLeading: false, // Disable the back button
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Display the order confirmation image
              Image.asset(
                "assets/Victors/sendorder.png",
                width: getWidth(context, 80),
                height: getWidth(context, 80),
              ),
              // Display a thank you message
              Text(
                "Thank You!".tr,
                style: TextStyle(
                  fontSize: 24,
                  color: mainColorBlack,
                  fontFamily: mainFontbold,
                ),
              ),
              SizedBox(
                height: getHeight(context, 1),
              ),
              Text(
                "for yor order".tr, // Display order confirmation message
                style: TextStyle(
                  fontSize: 16,
                  color: mainColorBlack,
                  fontFamily: mainFontnormal,
                ),
              ),
              SizedBox(
                height: getHeight(context, 1),
              ),
              // Display the order number
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order Number".tr + " : ",
                    style: TextStyle(
                      fontSize: 16,
                      color: mainColorBlack,
                      fontFamily: mainFontbold,
                    ),
                  ),
                  Text(
                    widget.id,
                    style: TextStyle(
                      fontSize: 16,
                      color: mainColorRed,
                      fontFamily: mainFontbold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              // Display message based on delivery range status
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: Text(
                  widget.outrange
                      ? "sorryWeDoNotHaveDelivery".tr +
                          " " +
                          productrovider.startTime.toString() +
                          " " +
                          "am".tr
                      : "YourOrderIsNowBeingProcessed".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: mainColorBlack,
                    fontFamily: mainFontnormal,
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, 5),
              ),
              // Display options based on delivery range status
              widget.outrange
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context, 4),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Navigate to the home screen if delivery is out of range
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavSwitch()),
                          );
                        },
                        style: TextButton.styleFrom(
                          fixedSize: Size(
                            getWidth(context, 85),
                            getHeight(context, 6),
                          ),
                        ),
                        child: Text(
                          "Yes i Agree".tr,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context, 4),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Navigate to the track order screen and then to the home screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrackOrder(
                                      int.parse(widget.id),
                                    )),
                          ).then((value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavSwitch()),
                            );
                          });
                        },
                        style: TextButton.styleFrom(
                          fixedSize: Size(
                            getWidth(context, 85),
                            getHeight(context, 6),
                          ),
                        ),
                        child: Text(
                          "Track My Order".tr,
                        ),
                      ),
                    ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              // Provide an option to cancel the order if delivery is out of range
              widget.outrange
                  ? TextButton(
                      onPressed: () {
                        Network(false)
                            .postData("userCancel", {"oid": widget.id}, context)
                            .then((value) {
                          if (value != "") {
                            if (value["code"] == "201") {
                              // Refresh the order data and navigate to the home screen
                              final productrovider =
                                  Provider.of<productProvider>(context,
                                      listen: false);
                              productrovider.refreshOrderData();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavSwitch()),
                              );
                            }
                          }
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: mainColorRed,
                        fixedSize: Size(
                          getWidth(context, 85),
                          getHeight(context, 6),
                        ),
                      ),
                      child: Text(
                        "No, Cancel order".tr,
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        // Navigate to the home screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => NavSwitch()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: mainColorRed,
                        fixedSize: Size(
                          getWidth(context, 85),
                          getHeight(context, 6),
                        ),
                      ),
                      child: Text(
                        "Back to Home".tr,
                      ),
                    ),
              SizedBox(
                height: getHeight(context, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
