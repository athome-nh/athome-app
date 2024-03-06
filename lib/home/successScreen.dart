import 'package:dllylas/Config/property.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/home/track_order.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class successScreen extends StatefulWidget {
  String total = "";
  String id = "";
  String time = "";
  bool outrange = false;
  successScreen(this.total, this.id, this.time, this.outrange, {super.key});

  @override
  State<successScreen> createState() => _successScreenState();
}

class _successScreenState extends State<successScreen> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);


    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Ordered successfully".tr,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/Victors/sendorder.png",
                width: getWidth(context, 80),
                height: getWidth(context, 80),
              ),
              Text("Thank You!".tr,
                  style: TextStyle(
                    fontSize: 24,
                    color: mainColorBlack,
                    fontFamily: mainFontbold,
                  )),
              SizedBox(
                height: getHeight(context, 1),
              ),
              Text("for yor order".tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: mainColorBlack,
                    fontFamily: mainFontnormal,
                  )),
              SizedBox(
                height: getHeight(context, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order Number:".tr,
                    style: TextStyle(
                        fontSize: 16,
                        color: mainColorBlack,
                        fontFamily: mainFontbold),
                  ),
                  Text(
                    widget.id,
                    style: TextStyle(
                        fontSize: 16,
                        color: mainColorRed,
                        fontFamily: mainFontbold),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: Text(
                  widget.outrange
                      ? "sorryWeDoNotHaveDelivery".tr+" "+productrovider.startTime.toString()+" "+"am".tr
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
              widget.outrange
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context, 4),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavSwitch()),
                          );
                        },
                        style: TextButton.styleFrom(
                          fixedSize: Size(
                              getWidth(context, 85), getHeight(context, 6)),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrackOrder(
                                    widget.id, widget.total, widget.time)),
                          ).then((value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NavSwitch()),
                            );
                          });
                        },
                        style: TextButton.styleFrom(
                          fixedSize: Size(
                              getWidth(context, 85), getHeight(context, 6)),
                        ),
                        child: Text(
                          "Track My Order".tr,
                        ),
                      ),
                    ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              widget.outrange
                  ? TextButton(
                      onPressed: () {
                        Network(false)
                            .postData("userCancel", {"oid": widget.id}, context)
                            .then((value) {
                          if (value != "") {
                            if (value["code"] == "201") {
                              final productrovider =
                                  Provider.of<productProvider>(context,
                                      listen: false);
                              productrovider
                                  .getuserdata(userdata["id"].toString());
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NavSwitch()),
                              );
                            }
                          }
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: mainColorRed,
                        fixedSize:
                            Size(getWidth(context, 85), getHeight(context, 6)),
                      ),
                      child: Text(
                        "No, Cancel order".tr,
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavSwitch()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: mainColorRed,
                        fixedSize:
                            Size(getWidth(context, 85), getHeight(context, 6)),
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
