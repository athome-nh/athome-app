// Import necessary packages and libraries
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/property.dart';

// VoucherCodePage is a StatefulWidget that displays vouchers in different tabs: Active, Used, and Expired.
class VoucherCodePage extends StatefulWidget {
  const VoucherCodePage({super.key});

  @override
  State<VoucherCodePage> createState() => _VoucherCodePageState();
}

class _VoucherCodePageState extends State<VoucherCodePage> {
  @override
  Widget build(BuildContext context) {
    // DefaultTabController manages the state of the tab bar and the tab views.
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Vouchers'.tr), // Title of the app bar, translated
          bottom: TabBar(
            // TabBar to switch between different voucher categories
            tabs: [
              Tab(text: "Active".tr),   // Tab for active vouchers
              Tab(text: "Used".tr),     // Tab for used vouchers
              Tab(text: "Expired".tr),  // Tab for expired vouchers
            ],
          ),
        ),
        body: TabBarView(
          // TabBarView to display content for each tab
          children: [
            ActiveTab(),  // Widget to display active vouchers
            UsedTab(),    // Widget to display used vouchers
            ExpiredTab(), // Widget to display expired vouchers
          ],
        ),
      ),
    );
  }
}

// ActiveTab displays the list of active (unused) vouchers.
class ActiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the productProvider to get unused vouchers
    final productrovider = Provider.of<productProvider>(context, listen: true);
    
    // Directionality widget sets the text direction based on the language
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.unusedVouchers.isEmpty
          ? Center(
              // Displayed when there are no unused vouchers
              child: Text(
                "Do not have any Voucher Code".tr, // Translated message
                style: TextStyle(
                  fontFamily: mainFontnormal, // Font style
                  fontSize: 20, // Font size
                  color: mainColorGrey, // Text color
                ),
              ),
            )
          : ListView.builder(
              // ListView.builder to display a list of active vouchers
              itemCount: productrovider.unusedVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.unusedVouchers[index]; // Get voucher by index
                return Padding(
                  padding: const EdgeInsets.all(8), // Padding around each voucher item
                  child: Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mainColorGrey2), // Border color
                            borderRadius: BorderRadius.circular(15), // Rounded corners
                            color: mainColorlightGrey), // Background color
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8), // Padding inside the container
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/images/Voucher.png", // Voucher image
                                    height: getHeight(context, 6), // Image height
                                  ),
                                  SizedBox(width: getWidth(context, 3)), // Spacing
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Discont".tr + " ", // Discount label
                                            style: new TextStyle(
                                              fontFamily: mainFontbold, // Bold font style
                                              color: mainColorBlack, // Text color
                                              fontSize: 14, // Font size
                                            ),
                                          ),
                                          Text(
                                            addCommasToPriceWithoutIQD(
                                                voucher.discountAmount!), // Discount amount
                                            style: new TextStyle(
                                              fontFamily: mainFontbold,
                                              color: mainColorBlack,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            " " + "IQD".tr, // Currency label
                                            style: new TextStyle(
                                              fontFamily: mainFontbold,
                                              color: mainColorBlack,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        lang == "en"
                                            ? voucher.titleEn!
                                            : lang == "ar"
                                                ? voucher.titleAr!
                                                : voucher.titleKu!, // Voucher title based on language
                                        style: new TextStyle(
                                          fontFamily: mainFontbold,
                                          color: mainColorRed, // Title color
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0), // Padding around the status indicator
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Active".tr, // Status label for active vouchers
                                  style: TextStyle(
                                      fontSize: 10, // Font size
                                      fontFamily: mainFontnormal, // Font style
                                      color: mainColorBlack), // Text color
                                ),
                                Text(
                                  "Date".tr + ": " +
                                      convertToBaghdadTime(voucher.expireDate!), // Expiry date
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                )
                              ],
                            ),
                            SizedBox(width: 5), // Space between text and icon
                            Icon(
                              Icons.circle, // Status indicator icon
                              size: 15, // Icon size
                              color: green, // Color indicating active status
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// UsedTab displays the list of used vouchers.
class UsedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the productProvider to get used vouchers
    final productrovider = Provider.of<productProvider>(context, listen: true);
    
    // Directionality widget sets the text direction based on the language
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.usedVouchers.isEmpty
          ? Center(
              // Displayed when there are no used vouchers
              child: Text(
                "Do not have any Voucher Code".tr, // Translated message
                style: TextStyle(
                  fontFamily: mainFontnormal,
                  fontSize: 20,
                  color: mainColorGrey,
                ),
              ),
            )
          : ListView.builder(
              // ListView.builder to display a list of used vouchers
              itemCount: productrovider.usedVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.usedVouchers[index]; // Get voucher by index
                return Padding(
                  padding: const EdgeInsets.all(8), // Padding around each voucher item
                  child: Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mainColorGrey2), // Border color
                            borderRadius: BorderRadius.circular(15), // Rounded corners
                            color: mainColorlightGrey), // Background color
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8), // Padding inside the container
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        "assets/images/Voucher.png", // Voucher image
                                        height: getHeight(context, 6), // Image height
                                      ),
                                      SizedBox(width: getWidth(context, 3)), // Spacing
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Discont".tr + " ", // Discount label
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold, // Bold font style
                                                  color: mainColorBlack, // Text color
                                                  fontSize: 14, // Font size
                                                ),
                                              ),
                                              Text(
                                                addCommasToPriceWithoutIQD(
                                                    voucher.discountAmount!), // Discount amount
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                " " + "IQD".tr, // Currency label
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            lang == "en"
                                                ? voucher.titleEn!
                                                : lang == "ar"
                                                    ? voucher.titleAr!
                                                    : voucher.titleKu!, // Voucher title based on language
                                            style: new TextStyle(
                                              fontFamily: mainFontbold,
                                              color: mainColorRed, // Title color
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0), // Padding around the status indicator
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Used".tr, // Status label for used vouchers
                                  style: TextStyle(
                                      fontSize: 18, // Font size
                                      fontFamily: mainFontnormal,
                                      color: mainColorGrey), // Text color
                                ),
                                Text(
                                  "Expired".tr, // Status label for expired vouchers
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                ),
                                Text(
                                  "Date".tr + ": " +
                                      convertToBaghdadTime(voucher.expireDate!), // Expiry date
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                )
                              ],
                            ),
                            SizedBox(width: 5), // Space between text and icon
                            Icon(
                              Icons.circle, // Status indicator icon
                              size: 15, // Icon size
                              color: mainColorlightGrey, // Color indicating used status
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// ExpiredTab displays the list of expired vouchers.
class ExpiredTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the productProvider to get expired vouchers
    final productrovider = Provider.of<productProvider>(context, listen: true);
    
    // Directionality widget sets the text direction based on the language
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.expireVouchers.isEmpty
          ? Center(
              // Displayed when there are no expired vouchers
              child: Text(
                "Do not have any Voucher Code".tr, // Translated message
                style: TextStyle(
                  fontFamily: mainFontnormal,
                  fontSize: 20,
                  color: mainColorGrey,
                ),
              ),
            )
          : ListView.builder(
              // ListView.builder to display a list of expired vouchers
              itemCount: productrovider.expireVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.expireVouchers[index]; // Get voucher by index
                return Padding(
                  padding: const EdgeInsets.all(8), // Padding around each voucher item
                  child: Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mainColorGrey2), // Border color
                            borderRadius: BorderRadius.circular(15), // Rounded corners
                            color: mainColorlightGrey), // Background color
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8), // Padding inside the container
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        "assets/images/Voucher.png", // Voucher image
                                        height: getHeight(context, 6), // Image height
                                      ),
                                      SizedBox(width: getWidth(context, 3)), // Spacing
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Discont".tr + " ", // Discount label
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold, // Bold font style
                                                  color: mainColorBlack, // Text color
                                                  fontSize: 14, // Font size
                                                ),
                                              ),
                                              Text(
                                                addCommasToPriceWithoutIQD(
                                                    voucher.discountAmount!), // Discount amount
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                " " + "IQD".tr, // Currency label
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            lang == "en"
                                                ? voucher.titleEn!
                                                : lang == "ar"
                                                    ? voucher.titleAr!
                                                    : voucher.titleKu!, // Voucher title based on language
                                            style: new TextStyle(
                                              fontFamily: mainFontbold,
                                              color: mainColorRed, // Title color
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0), // Padding around the status indicator
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Expired".tr, // Status label for expired vouchers
                                  style: TextStyle(
                                      fontSize: 10, // Font size
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack), // Text color
                                ),
                                Text(
                                  "Date".tr + ": " +
                                      convertToBaghdadTime(voucher.expireDate!), // Expiry date
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                )
                              ],
                            ),
                            SizedBox(width: 5), // Space between text and icon
                            Icon(
                              Icons.circle, // Status indicator icon
                              size: 15, // Icon size
                              color: mainColorRed, // Color indicating expired status
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
