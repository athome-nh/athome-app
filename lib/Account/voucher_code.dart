import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/property.dart';

class VoucherCodePage extends StatefulWidget {
  const VoucherCodePage({super.key});

  @override
  State<VoucherCodePage> createState() => _VoucherCodePageState();
}

class _VoucherCodePageState extends State<VoucherCodePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Vouchers'.tr),
          bottom: TabBar(
            tabs: [
              Tab(text: "Active".tr),
              Tab(text: "Used".tr),
              Tab(text: "Expired".tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveTab(),
            UsedTab(),
            ExpiredTab(),
          ],
        ),
      ),
    );
  }
}

class ActiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.unusedVouchers.isEmpty
          ? Center(
              child: Text(
                "Do not have any Voucher Code".tr,
                style: TextStyle(
                  fontFamily: mainFontnormal,
                  fontSize: 20,
                  color: mainColorGrey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: productrovider.unusedVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.unusedVouchers[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mainColorGrey2),
                            borderRadius: BorderRadius.circular(15),
                            color: mainColorlightGrey),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
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
                                      // voucher image
                                      Image.asset(
                                        "assets/images/Voucher.png",
                                        height: getHeight(context, 6),
                                      ),

                                      SizedBox(
                                        width: getWidth(context, 3),
                                      ),

                                      // Text
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "IQD" + " ",
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                addCommasToPriceWithoutIQD(
                                                    voucher.discountAmount!),
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                " " + "Discont",
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
                                                    : voucher.titleKu!,
                                            style: new TextStyle(
                                              fontFamily: mainFontbold,
                                              color: mainColorRed,
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
                      // date
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Active",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                ),
                                Text(
                                  "Date:" + formatDate(DateTime.parse(voucher.expireDate!)),
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                )
                              ],
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.circle,
                              size: 15,
                              color: green,
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

class UsedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.usedVouchers.isEmpty
          ? Center(
              child: Text(
                "Do not have any Voucher Code".tr,
                style: TextStyle(
                  fontFamily: mainFontnormal,
                  fontSize: 20,
                  color: mainColorGrey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: productrovider.usedVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.usedVouchers[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mainColorGrey2),
                            borderRadius: BorderRadius.circular(15),
                            color: mainColorlightGrey),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
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
                                      // voucher image
                                      Image.asset(
                                        "assets/images/Voucher.png",
                                        height: getHeight(context, 6),
                                      ),

                                      SizedBox(
                                        width: getWidth(context, 3),
                                      ),

                                      // Text
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "IQD" + " ",
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                addCommasToPriceWithoutIQD(
                                                    voucher.discountAmount!),
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                " " + "Discont",
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
                                                    : voucher.titleKu!,
                                            style: new TextStyle(
                                              fontFamily: mainFontbold,
                                              color: mainColorRed,
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
                      // date
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Active",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                ),
                                Text(
                                  "Date:" + formatDate(DateTime.parse(voucher.expireDate!)),
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                )
                              ],
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.circle,
                              size: 15,
                              color: mainColorRed,
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

class ExpiredTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.expireVouchers.isEmpty
          ? Center(
              child: Text(
                "Do not have any Voucher Code".tr,
                style: TextStyle(
                  fontFamily: mainFontnormal,
                  fontSize: 20,
                  color: mainColorGrey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: productrovider.expireVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.expireVouchers[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: lang == "en"
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mainColorGrey2),
                            borderRadius: BorderRadius.circular(15),
                            color: mainColorlightGrey),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
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
                                      // voucher image
                                      Image.asset(
                                        "assets/images/Voucher.png",
                                        height: getHeight(context, 6),
                                      ),

                                      SizedBox(
                                        width: getWidth(context, 3),
                                      ),

                                      // Text
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "IQD" + " ",
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                addCommasToPriceWithoutIQD(
                                                    voucher.discountAmount!),
                                                style: new TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorBlack,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                " " + "Discont",
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
                                                    : voucher.titleKu!,
                                            style: new TextStyle(
                                              fontFamily: mainFontbold,
                                              color: mainColorRed,
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
                      // date
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Active",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                ),
                                Text(
                                  "Date:" + formatDate(DateTime.parse(voucher.expireDate!)),
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: mainFontnormal,
                                      color: mainColorBlack),
                                )
                              ],
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.circle,
                              size: 15,
                              color: mainColorRed,
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

class UsedTabOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.usedVouchers.isEmpty
          ? Center(
              child: Text(
                "Do not have any Voucher Code".tr,
                style: TextStyle(
                  fontFamily: mainFontnormal,
                  fontSize: 20,
                  color: mainColorGrey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: productrovider.usedVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.usedVouchers[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: getHeight(context, 17),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: mainColorBlack.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Container(
                          width: getWidth(context, 100),
                          height: getHeight(context, 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                              color: mainColorGrey),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/App-Icon.png",
                                height: 50,
                              ),
                              Text(
                                lang == "en"
                                    ? voucher.titleEn!
                                    : lang == "ar"
                                        ? voucher.titleAr!
                                        : voucher.titleKu!,
                                style: TextStyle(
                                    color: mainColorWhite, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: new TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                      text: addCommasToPrice(
                                          voucher.discountAmount!),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: mainFontnormal),
                                    ),
                                    new TextSpan(
                                      text: " OFF",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: mainColorRed,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: mainFontnormal),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                voucher.expireDate!,
                                style: TextStyle(
                                    color: mainColorBlack, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ExpiredTabOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.expireVouchers.isEmpty
          ? Center(
              child: Text(
                "Do not have any Voucher Code".tr,
                style: TextStyle(
                  fontFamily: mainFontnormal,
                  fontSize: 20,
                  color: mainColorGrey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: productrovider.expireVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.expireVouchers[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: getHeight(context, 17),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: mainColorBlack.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Container(
                          width: getWidth(context, 100),
                          height: getHeight(context, 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                              color: mainColorGrey),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/App-Icon.png",
                                height: 50,
                              ),
                              Text(
                                lang == "en"
                                    ? voucher.titleEn!
                                    : lang == "ar"
                                        ? voucher.titleAr!
                                        : voucher.titleKu!,
                                style: TextStyle(
                                    color: mainColorWhite, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: new TextSpan(
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                      text: addCommasToPrice(
                                          voucher.discountAmount!),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: mainFontnormal),
                                    ),
                                    new TextSpan(
                                      text: " OFF",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: mainColorRed,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: mainFontnormal),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                voucher.expireDate!,
                                style: TextStyle(
                                    color: mainColorRed, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
