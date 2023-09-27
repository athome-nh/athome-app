import 'package:flutter/material.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Home/NavSwitch.dart';
import 'package:athome/Home/TrackOrder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
              color: mainColorGrey,
              fontFamily: mainFontMontserrat4,
              fontSize: 24),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: getWidth(context, 100),
              height: getHeight(context, 15),
              decoration: BoxDecoration(
                color: mainColorWhite,
              ),
              child: Padding(
                padding: EdgeInsets.all(getWidth(context, 4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Address".tr,
                      style: TextStyle(
                          color: mainColorGrey,
                          fontFamily: mainFontMontserrat4,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: getHeight(context, 1.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.end,
                              "Erbil ,Italian City 1",
                              style: TextStyle(
                                  color: mainColorGrey,
                                  fontFamily: mainFontMontserrat6,
                                  fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              textAlign: TextAlign.end,
                              "House Number 646",
                              style: TextStyle(
                                  color: mainColorGrey,
                                  fontFamily: mainFontMontserrat6,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Change".tr,
                            style: TextStyle(
                                color: mainColorRed,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 2),
              child: Container(
                color: Color(0xffF2F2F2),
              ),
            ),
            Container(
              width: getWidth(context, 100),
              height: getHeight(context, 30),
              decoration: BoxDecoration(
                color: mainColorWhite,
              ),
              child: Padding(
                padding: EdgeInsets.all(getWidth(context, 4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pyment Method".tr,
                      style: TextStyle(
                          color: mainColorGrey,
                          fontFamily: mainFontMontserrat4,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: getHeight(context, 5),
                        width: getWidth(context, 90),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF2F2F2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cash on delivery".tr,
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontMontserrat4,
                                    fontSize: 12),
                              ),
                              Icon(
                                Icons.circle,
                                color: mainColorRed,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: getHeight(context, 5),
                        width: getWidth(context, 90),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF2F2F2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CachedNetworkImage(
                                  imageUrl: "assets/images/fib.png"),
                              Icon(
                                Icons.circle_outlined,
                                color: mainColorRed,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: getHeight(context, 5),
                        width: getWidth(context, 90),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF2F2F2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CachedNetworkImage(
                                  imageUrl: "assets/images/fast.png"),
                              Icon(
                                Icons.circle_outlined,
                                color: mainColorRed,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 2),
              child: Container(
                color: Color(0xffF2F2F2),
              ),
            ),
            Container(
              width: getWidth(context, 100),
              height: getHeight(context, 20),
              decoration: BoxDecoration(
                color: mainColorWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sub Total".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat4,
                                fontSize: 13),
                          ),
                          Text(
                            textAlign: TextAlign.end,
                            "20,000 IQD",
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Cost".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat4,
                                fontSize: 13),
                          ),
                          Text(
                            textAlign: TextAlign.end,
                            "20,000 IQD",
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat4,
                                fontSize: 13),
                          ),
                          Text(
                            textAlign: TextAlign.end,
                            "20,000 IQD",
                            style: TextStyle(
                                color: mainColorRed,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      child: Divider(
                          color: mainColorGrey.withOpacity(0.2), thickness: 1),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "Total",
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat4,
                                fontSize: 13),
                          ),
                          Text(
                            textAlign: TextAlign.end,
                            "40,000 IQD",
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 2),
              child: Container(
                color: Color(0xffF2F2F2),
              ),
            ),
            Container(
              width: getWidth(context, 100),
              height: getHeight(context, 15),
              decoration: BoxDecoration(
                color: mainColorWhite,
              ),
              child: Padding(
                padding: EdgeInsets.all(getWidth(context, 4)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isDismissible: false,
                            enableDrag: false,
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
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        color: mainColorRed,
                                        size: getHeight(context, 20),
                                      ),
                                      Text(
                                        "Thank You!".tr,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat4),
                                      ),
                                      Text(
                                        "for yor order".tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat4),
                                      ),
                                      SizedBox(
                                        height: getHeight(context, 1),
                                      ),
                                      Text(
                                        "Order Number: 5509".tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat6),
                                      ),
                                      SizedBox(
                                        height: getHeight(context, 1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getWidth(context, 4)),
                                        child: Text(
                                          "Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order".tr,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: mainColorGrey,
                                              fontFamily: mainFontMontserrat4),
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(context, 2),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getWidth(context, 4)),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TrackOrder()),
                                            );
                                          },
                                          child: Text(
                                            "Track My Order".tr,
                                            style: TextStyle(
                                              color: mainColorWhite,
                                              fontSize: 16,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: mainColorRed,
                                            fixedSize: Size(
                                                getWidth(context, 85),
                                                getHeight(context, 6)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NavSwitch()),
                                          ); // Close the bottom sheet
                                        },
                                        child: Text(
                                          "Back to Home".tr,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontFamily: mainFontMontserrat4,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "Send Order",
                          style: TextStyle(
                            color: mainColorWhite,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColorRed,
                          fixedSize: Size(
                              getWidth(context, 85), getHeight(context, 6)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
