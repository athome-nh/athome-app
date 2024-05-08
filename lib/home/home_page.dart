import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Home/all_item.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/Notfication.dart';
import 'package:dllylas/home/item_categories.dart';

import 'package:dllylas/home/search_page.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/cart.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Home/Categories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  update(BuildContext context) async {
    final productrovider = Provider.of<productProvider>(context, listen: false);
    await Isolate.run(productrovider.updatePost(false));
    // productrovider.updatePost(false);
  }

  _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.manufacturer;
  }

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // Check Internet
  Future<void> checkinternet() async {
    // if (await noInternet(context)) {
    //   Provider.of<productProvider>(context, listen: false)
    //       .setnointernetcheck(true);
    //   return;
    // }

    if (loaddata) {
      // update(context);
    } else {
      final productrovider =
          Provider.of<productProvider>(context, listen: false);
      final cartprovider = Provider.of<CartProvider>(context, listen: false);
      List<CartItem> mycart = cartprovider.cartItems;
      for (var item in mycart) {
        final existingItemIndex = productrovider.products.indexWhere(
          (element) => element.id == item.product,
        );
        if (existingItemIndex == -1) {
          cartprovider.cartItems.remove(cartprovider.cartItems[item.product]);
        }
      }
      List<CartItem> myfav = cartprovider.FavItems;
      for (var item in myfav) {
        final existingItemIndex = productrovider.products.indexWhere(
          (element) => element.id == item.product,
        );
        if (existingItemIndex == -1) {
          cartprovider.FavItems.remove(cartprovider.FavItems[item.product]);
        }
      }
      loaddata = true;
    }
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("onLoad")
        .doc("1")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get("show") == false) {
          if (lang == "en") {
            ShowInfo(context, documentSnapshot.get("titleen"),
                documentSnapshot.get("contenten"), "OK".tr, "error");
          } else if (lang == "ar") {
            ShowInfo(context, documentSnapshot.get("titlear"),
                documentSnapshot.get("contentar"), "OK".tr, "error");
          } else {
            ShowInfo(context, documentSnapshot.get("titleku"),
                documentSnapshot.get("contentku"), "OK".tr, "error");
          }
        }
        if (dotenv.env['currentVersion']! !=
                documentSnapshot.get("newversion") &&
            documentSnapshot.get("isAccpet")) {
          ShowInfo(
              context,
              "New update is available".tr,
              "A newer version of dlly las application is available, please download the latest version ."
                  .tr,
              "Update".tr,
              "update");
        }
      }
    });

    checkinternet();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final pro = Provider.of<productProvider>(context, listen: false);
    if (result[0] == ConnectivityResult.none) {
      pro.setnointernetcheck(true);
    } else {
      if (pro.nointernetCheck) {
        pro.updatePost(false);
        pro.setnointernetcheck(false);
      }
    }
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);

    return productrovider.nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                  body:
                      // body
                      SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      title: Text(
                        "Wellcome to".tr,
                        style:
                            TextStyle(fontSize: 12, fontFamily: mainFontnormal),
                      ),
                      subtitle: RichText(
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                              text: 'Dlly Las '.tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: mainColorGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: mainFontnormal),
                            ),
                            new TextSpan(
                              text: 'Supermarket'.tr,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: mainColorRed,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: mainFontnormal),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.notifications_none_outlined,
                          color: mainColorRed,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotficationScreen()),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Search()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 4)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: mainColorBlack.withOpacity(0.1))),
                          height: 50,
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.search_outline,
                                color: mainColorBlack,
                                size: 22,
                              ),
                              SizedBox(
                                width: getWidth(context, 1),
                              ),
                              Text(
                                "Search".tr,
                                style: TextStyle(
                                    fontFamily: mainFontnormal,
                                    color: mainColorBlack.withOpacity(0.8),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Space
                    SizedBox(
                      height: getHeight(context, 1),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      child: Visibility(
                        visible: productrovider.show,
                        replacement: Skeletonizer(
                          effect: ShimmerEffect.raw(colors: [
                            mainColorGrey.withOpacity(0.1),
                            mainColorWhite,
                            //  mainColorRed.withOpacity(0.1),
                          ]),
                          enabled: true,
                          child: SizedBox(
                            width: getWidth(context, 100),
                            height: getHeight(context, 25),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: CarouselSlider(
                                items: [
                                  ClipRRect(
                                    child: Image.asset(
                                      "assets/images/Logo-Type-2.png",
                                      width: getWidth(context, 100),
                                      height: getHeight(context, 20),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 3000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: getWidth(context, 100),
                          height: getHeight(context, 25),
                          child: CarouselSlider.builder(
                            itemCount: productrovider.slides.length,
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              enlargeCenterPage: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 3000),
                              enableInfiniteScroll:
                                  true, // if you don't want infinite loop
                              onPageChanged: (index, reason) {
                                // Do something when page changes
                              },
                            ),
                            itemBuilder: (BuildContext context, int index, _) {
                              var item = productrovider.slides[index];
                              return GestureDetector(
                                onTap: () {
                                  productrovider.settype("brand");
                                  productrovider.setidbrand(item.brandId!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AllItem()),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: CachedNetworkImage(
                                    imageUrl: dotenv.env['imageUrlServer']! +
                                        item.img!,
                                    placeholder: (context, url) => Image.asset(
                                        "assets/images/Logo-Type-2.png"),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/Logo-Type-2.png"),
                                    filterQuality: FilterQuality.low,
                                    width: getWidth(context, 100),
                                    height: getHeight(context, 20),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // Categories
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Text(
                            "Categories".tr,
                            style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 16,
                                fontFamily: mainFontbold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: TextButton(
                            onPressed: () {
                              !productrovider.show
                                  ? const SizedBox()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Categories()),
                                    );
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: mainColorRed,
                                backgroundColor: Colors.transparent),
                            child: Row(
                              children: [
                                Text(
                                  "View All".tr,
                                ),
                                // SizedBox(
                                //   width: getWidth(context, 2),
                                // ),
                                // Icon(
                                //   Icons.arrow_forward_ios_outlined,
                                //   color: mainColorRed,
                                //   size: 14,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Shimmer Effect
                    SizedBox(
                      height: getHeight(context, 14),
                      child: Visibility(
                        visible: productrovider.show,
                        replacement: Skeletonizer(
                          effect: ShimmerEffect.raw(colors: [
                            mainColorGrey.withOpacity(0.1),
                            mainColorWhite,
                            //   mainColorRed.withOpacity(0.1),
                          ]),
                          enabled: true,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 4)),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: getHeight(context, 8),
                                      height: getHeight(context, 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: mainColorBlack
                                                  .withOpacity(0.1)),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                          child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://www.dllylas.com/assets/img/logo/logo.png",
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  "assets/images/home.png"),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/home.png"),
                                          fit: BoxFit.fill,
                                          width: getHeight(context, 5),
                                          height: getHeight(context, 5),
                                        ),
                                      )),
                                    ),
                                    SizedBox(
                                      height: getHeight(context, 1),
                                    ),
                                    Text(
                                      "cateItem",
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontFamily: mainFontnormal,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productrovider.categores.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cateItem = productrovider.categores[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 4)),
                              child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      productrovider.setcatetype(cateItem.id!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                itemCategories()),
                                      ).then((value) {
                                        productrovider.setsubcateSelect(0);
                                      });
                                    },
                                    child: Container(
                                      width: getHeight(context, 9),
                                      height: getHeight(context, 9),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: mainColorBlack
                                                  .withOpacity(0.1)),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              dotenv.env['imageUrlServer']! +
                                                  cateItem.img!,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  "assets/images/Logo-Type-2.png"),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/Logo-Type-2.png"),
                                          filterQuality: FilterQuality.low,
                                          width: getHeight(context, 7),
                                          height: getHeight(context, 7),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(context, 1),
                                  ),
                                  Text(
                                    lang == "en"
                                        ? cateItem.nameEn!
                                        : lang == "ar"
                                            ? cateItem.nameAr!
                                            : cateItem.nameKu!,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: mainColorBlack,
                                        fontFamily: mainFontnormal,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    productrovider.Orderitems.isNotEmpty &&
                            productrovider
                                .getProductsByIds2(
                                  productrovider.listOrderProductIds(),
                                )
                                .isNotEmpty
                        ? Column(
                            children: [
                              // Recent Order
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 4)),
                                    child: Text(
                                      "Recent Order".tr,
                                      style: TextStyle(
                                          color: mainColorBlack,
                                          fontSize: 16,
                                          fontFamily: mainFontbold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 4)),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            if (productrovider.show) {
                                              productrovider.settype("orders");
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AllItem()),
                                              );
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                              foregroundColor: mainColorRed,
                                              backgroundColor:
                                                  Colors.transparent),
                                          child: Text(
                                            "View All".tr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              listItemsSmall(
                                context,
                                productrovider.getProductsByIds2(
                                  productrovider.listOrderProductIds(),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),

                    productrovider.getProductsByDiscount().isNotEmpty
                        ? Column(
                            children: [
                              // Discount
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 4)),
                                    child: Text(
                                      "Discount".tr,
                                      style: TextStyle(
                                          color: mainColorBlack,
                                          fontSize: 16,
                                          fontFamily: mainFontbold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 4)),
                                    child: TextButton(
                                      onPressed: () {
                                        if (productrovider.show) {
                                          productrovider.settype("discount");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AllItem()),
                                          );
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: mainColorRed,
                                          backgroundColor: Colors.transparent),
                                      child: Row(
                                        children: [
                                          Text(
                                            "View All".tr,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              listItemsSmall(
                                context,
                                productrovider.getProductsByDiscount(),
                              ),
                            ],
                          )
                        : const SizedBox(),

                    // Highlight
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Text(
                            "Highlight".tr,
                            style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 16,
                                fontFamily: mainFontbold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: TextButton(
                            onPressed: () {
                              if (productrovider.show) {
                                productrovider.settype("Highlight");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AllItem()),
                                );
                              }
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: mainColorRed,
                                backgroundColor: Colors.transparent),
                            child: Row(
                              children: [
                                Text(
                                  "View All".tr,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    listItemsSmall(
                      context,
                      productrovider.getProductsByHighlight(),
                    ),

                    // Space
                    SizedBox(
                      height: getHeight(context, 1),
                    ),

                    // Best Seller
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Text(
                            "Best Sell".tr,
                            style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 16,
                                fontFamily: mainFontbold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (productrovider.show) {
                                    productrovider.settype("best");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AllItem()),
                                    );
                                  }
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: mainColorRed,
                                    backgroundColor: Colors.transparent),
                                child: Row(
                                  children: [
                                    Text(
                                      "View All".tr,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    listItemsSmall(
                        context, productrovider.getProductsByBestsell()),

                    // Space
                    SizedBox(
                      height: getHeight(context, 2),
                    )
                  ],
                ),
              )),
            ),
          );
  }

  Future<void> ShowInfo(BuildContext context, String title, String content,
      String buttontxt, String type) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Stack(
              alignment: lang == "en" ? Alignment.topLeft : Alignment.topRight,
              children: [
                SizedBox(
                  width: getWidth(context, 100),
                  height: getHeight(context, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/Victors/info.png",
                        width: getWidth(context, 40),
                        height: getWidth(context, 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        title.tr,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontbold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        content,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontnormal,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () async {
                          if (type == "error") {
                            exit(0);
                          } else {
                            if (Platform.isAndroid) {
                              String check = _readAndroidBuildData(
                                  await deviceInfoPlugin.androidInfo);

                              if (check.toLowerCase() ==
                                  "HUAWEI".toLowerCase()) {
                                Uri url = Uri.parse(
                                    'https://appgallery.huawei.com/app/C109952685');
                                if (!await launchUrl(url,
                                    mode: LaunchMode.externalApplication)) {
                                  throw Exception('Could not launch $url');
                                }
                              } else {
                                Uri url = Uri.parse(
                                    'https://play.google.com/store/apps/details?id=com.market.dllylas');
                                if (!await launchUrl(url,
                                    mode: LaunchMode.externalApplication)) {
                                  throw Exception('Could not launch $url');
                                }
                              }
                            } else {
                              Uri url = Uri.parse(
                                  'https://apps.apple.com/iq/app/dlly-las-market/id6474247014');
                              if (!await launchUrl(url,
                                  mode: LaunchMode.externalApplication)) {
                                throw Exception('Could not launch $url');
                              }
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          fixedSize: Size(
                              getWidth(context, 70), getHeight(context, 5)),
                        ),
                        child: Text(
                          buttontxt,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
