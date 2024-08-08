import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:dllylas/Account/reward.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Config/slideshow.dart';
import 'package:dllylas/Landing/splash_screen.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/Notifications/notification_page.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/Categories.dart';
import 'package:dllylas/home/DetailsPage.dart';
import 'package:dllylas/home/alBrands.dart';
import 'package:dllylas/home/all_item.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/home/search_page.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/map/map_screen.dart';
import 'package:dllylas/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class newhomePage extends StatefulWidget {
  const newhomePage({super.key});

  @override
  State<newhomePage> createState() => _newhomePageState();
}

class _newhomePageState extends State<newhomePage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 1;
  int _oldPage = 0;
  TextEditingController feedbackController = TextEditingController();
  // List<String> selectedWords = [];
  int? selectedRating;
  bool isExpanded = false;
  bool waitingFeedback = false;

  List<String> ratestar = [
    'Poor',
    'Terrible',
    'Awful',
    'Unacceptable',
    'Dismal'
  ];
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

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

  void showhompopup() {
    if ((homePopupData["id"] != userdata["popupID"] ||
            homePopupData["isAlwaysShow"] == 1) &&
        homePopupData.isNotEmpty) {
      if (lang == "en") {
        _homePopup(context, "pop");
      } else if (lang == "ar") {
        _homePopup(context, "pop");
      } else {
        _homePopup(context, "pop");
      }

      if (homePopupData["id"] != userdata["popupID"] && userdata.isNotEmpty) {
        var data = {"id": userdata["id"], "popId": homePopupData["id"]};
        Network(false).postData("seen", data, context).then((value) {
          if (value != "") {
            if (value["code"] == "201") {
              userdata["popupID"] = homePopupData["id"];
            }
          }
        });
      }
      seenHomepopup = true;
    }
  }

  @override
  void initState() {
    final productrovider = Provider.of<productProvider>(context, listen: false);

    Timer(
      const Duration(seconds: 1),
      () {
        if (isLogin &&
            productrovider.showuser &&
            productrovider.location.isEmpty) {
          locationempty();
        } else if (isLogin &&
            productrovider.Orders.isNotEmpty &&
            productrovider.Orders.last.status == 5 &&
            productrovider.Orders.last.rating == null) {
          feedbackmMdal(context, productrovider);
        } else {
          if (!seenHomepopup) {
            showhompopup();
          }
        }
      },
    );

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
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);

    return productrovider.nointernetCheck
        ? noInternetWidget(context)
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wellcome to".tr,
                      style:
                          TextStyle(fontSize: 12, fontFamily: mainFontnormal),
                    ),
                    RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                            text: 'Dlly Las'.tr + " ",
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
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton.filledTonal(
                    style: IconButton.styleFrom(
                        backgroundColor: mainColorlightGrey),
                    icon: Icon(
                      Icons.notifications,
                      color: mainColorGrey2,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Search()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 1)),
                        decoration: BoxDecoration(
                            color: mainColorlightGrey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: mainColorlightGrey)),
                        height: getHeight(context, 6),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.search_outline,
                              color: mainColorGrey2,
                              size: 22,
                            ),
                            SizedBox(
                              width: getWidth(context, 2),
                            ),
                            Container(
                              height: 20,
                              width: 2,
                              color: mainColorGrey2,
                            ),
                            SizedBox(
                              width: getWidth(context, 2),
                            ),
                            Text(
                              "What are you searching for?".tr,
                              style: TextStyle(
                                  fontFamily: mainFontnormal,
                                  color: mainColorGrey2,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    Carousel(productrovider),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    Text(
                      "Categories".tr,
                      style: TextStyle(
                          color: mainColorBlack,
                          fontSize: 20,
                          fontFamily: mainFontbold),
                    ),
                    Visibility(
                      visible: productrovider.show,
                      replacement: Skeletonizer(
                        enabled: true,
                        effect: ShimmerEffect.raw(colors: [
                          mainColorGrey.withOpacity(0.1),
                          mainColorWhite,
                          //mainColorRed.withOpacity(0.1),
                        ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: getWidth(context, 55),
                                height: getHeight(context, 22),
                                decoration: BoxDecoration(
                                    color: mainColorlightGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  width: getWidth(context, 55),
                                  height: getHeight(context, 22),
                                  color: mainColorlightGrey,
                                )),
                            Container(
                              width: getWidth(context, 35),
                              height: getHeight(context, 22),
                              decoration: BoxDecoration(
                                  color: mainColorlightGrey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                alignment: lang == "en"
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                children: [
                                  PageView.builder(
                                    controller: _pageController,
                                    onPageChanged: (int page) {},
                                    scrollDirection: Axis.vertical,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Hello baby njas",
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: mainColorBlack,
                                                    fontFamily: mainFontbold,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                              Expanded(
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    10)),
                                                    child: Image.asset(
                                                      "assets/images/category.png",
                                                    )),
                                              ),
                                              Container(
                                                height: getHeight(context, 2.5),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: mainColorGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "See More",
                                                      style: TextStyle(
                                                          color: mainColorWhite,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 11),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: mainColorWhite,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              !productrovider.show
                                  ? const SizedBox()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Categories()),
                                    );
                            },
                            child: Stack(
                              alignment: lang == "en"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              children: [
                                Stack(
                                  alignment: lang == "en"
                                      ? Alignment.bottomLeft
                                      : Alignment.bottomRight,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: getWidth(context, 55),
                                      height: getHeight(context, 22),
                                      decoration: BoxDecoration(
                                          color: mainColorlightGrey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        'All Categories'.tr,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: mainColorGrey,
                                          fontFamily: mainFontbold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/images/category.png",
                                        width: getHeight(context, 15),
                                        height: getHeight(context, 15),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/images/meat.png",
                                        width: getHeight(context, 7),
                                        height: getHeight(context, 7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/images/baby.png",
                                        width: getHeight(context, 7),
                                        height: getHeight(context, 7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/images/care.png",
                                        width: getHeight(context, 7),
                                        height: getHeight(context, 7),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: getWidth(context, 35),
                            height: getHeight(context, 22),
                            decoration: BoxDecoration(
                                color: mainColorlightGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              alignment: lang == "en"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              children: [
                                PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      if (_activePage == 5) {
                                        if (_oldPage < page) {
                                          _oldPage = page;
                                          _activePage = 1;
                                        } else {
                                          _oldPage = page;
                                          _activePage = 4;
                                        }
                                      } else {
                                        if (_oldPage < page) {
                                          _oldPage = page;
                                          _activePage++;
                                        } else {
                                          if (_activePage == 1) {
                                            _oldPage = page;
                                            _activePage = 5;
                                          } else {
                                            _oldPage = page;
                                            _activePage--;
                                          }
                                        }
                                      }
                                    });
                                  },
                                  scrollDirection: Axis.vertical,
                                  itemCount: productrovider.categores.length,
                                  itemBuilder: (context, index) {
                                    final category =
                                        productrovider.categores[index];
                                    return GestureDetector(
                                      onTap: () {
                                        productrovider
                                            .setcatetype(category.id!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  itemCategories()),
                                        ).then((value) {
                                          productrovider.setsubcateSelect(0);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              lang == "en"
                                                  ? category.nameEn!
                                                  : lang == "ar"
                                                      ? category.nameAr!
                                                      : category.nameKu!,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: mainColorBlack,
                                                fontFamily: mainFontbold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            10)),
                                                child: CachedNetworkImage(
                                                  imageUrl: dotenv.env[
                                                          'imageUrlServer']! +
                                                      category.img!,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          "assets/images/Logo-Type-2.png"),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          "assets/images/Logo-Type-2.png"),
                                                  filterQuality:
                                                      FilterQuality.low,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: getHeight(context, 2.5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color: mainColorGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "See More".tr,
                                                    style: TextStyle(
                                                        color: mainColorWhite,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: mainColorWhite,
                                                    size: 15,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  height: getHeight(context, 10),
                                  width: getWidth(context, 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 1
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 2
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 3
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 4
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 5
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: getHeight(context, 2),
                    ),

                    Visibility(
                      visible: productrovider.show,
                      replacement: Skeletonizer(
                        child: Stack(
                          alignment: lang == "en"
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          children: [
                            Container(
                              width: getWidth(context, 100),
                              height: getHeight(context, 11),
                              decoration: BoxDecoration(
                                  color: mainColorlightGrey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: new TextSpan(
                                            children: <TextSpan>[
                                              new TextSpan(
                                                text: 'Hi'.tr + " ",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: mainColorGrey,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: mainFontnormal),
                                              ),
                                              new TextSpan(
                                                text: "sdjjsdkjd",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: mainColorRed,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: mainFontnormal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text("You are doing so well",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mainColorRed,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: mainFontnormal)),
                                        Row(
                                          children: [
                                            Skeleton.keep(
                                              child: Image.asset(
                                                "assets/images/star.png",
                                                width: getWidth(context, 6),
                                                height: getWidth(context, 6),
                                              ),
                                            ),
                                            Text(
                                              "5000",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: mainColorRed,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: mainFontbold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("data "),
                                        Text("data sdjj dhhdhd d dhdh"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: mainColorRed),
                              iconAlignment: IconAlignment.end,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                              label: Text(
                                "See More",
                                style: TextStyle(
                                    color: mainColorRed,
                                    fontFamily: mainFontnormal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              ),
                              onPressed: productrovider.show ? () {} : null,
                            )
                          ],
                        ),
                      ),
                      child: Stack(
                        alignment: lang == "en"
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        children: [
                          Container(
                            width: getWidth(context, 100),
                            height: getHeight(context, 12),
                            decoration: BoxDecoration(
                                color: mainColorlightGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(
                                              text: 'Hi'.tr + " ",
                                              style: TextStyle(
                                                  fontSize:
                                                      userdata["name"] == null
                                                          ? 12
                                                          : 16,
                                                  color: mainColorGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: mainFontnormal),
                                            ),
                                            new TextSpan(
                                              text: userdata["name"] == null
                                                  ? "Guest Account".tr
                                                  : userdata["name"]
                                                      .toString()
                                                      .split(" ")[0],
                                              style: TextStyle(
                                                  fontSize:
                                                      userdata["name"] == null
                                                          ? 12
                                                          : 16,
                                                  color: mainColorRed,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: mainFontnormal),
                                            ),
                                            // new TextSpan(
                                            //   text: "\n",
                                            // ),
                                            // new TextSpan(
                                            //   text: "You are doing so well".tr,
                                            //   style: TextStyle(
                                            //       fontSize: 8,
                                            //       color: mainColorGrey,
                                            //       fontWeight: FontWeight.bold,
                                            //       fontFamily: mainFontnormal),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/star.png",
                                            width: getWidth(context, 7),
                                            height: getWidth(context, 7),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            (userdata["point"] ?? "0")
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: getHeight(context, 3),
                                                color: mainColorRed,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: mainFontbold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    "assets/images/gobuy.png",
                                    width: getWidth(context, 45),
                                    height: getHeight(context, 6),
                                  )
                                ],
                              ),
                            ),
                          ),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: mainColorRed),
                            iconAlignment: IconAlignment.end,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            label: Text(
                              "See More".tr,
                              style: TextStyle(
                                  color: mainColorRed,
                                  fontFamily: mainFontnormal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                            onPressed: productrovider.show && isLogin
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const coinReward()),
                                    );
                                  }
                                : null,
                          )
                        ],
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
                              SizedBox(
                                height: getHeight(context, 1),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recent Order".tr,
                                    style: TextStyle(
                                        color: mainColorBlack,
                                        fontSize: 16,
                                        fontFamily: mainFontbold),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
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
                                        child: Text(
                                          "View All".tr,
                                          style: TextStyle(color: mainColorRed),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getHeight(context, 1),
                              ),
                              listItemsSmall(
                                  context,
                                  productrovider.getProductsByIds2(
                                    productrovider.listOrderProductIds(),
                                  ),
                                  false),
                            ],
                          )
                        : const SizedBox(),
                    productrovider.getProductsByDiscount().isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: getHeight(context, 1),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount".tr,
                                    style: TextStyle(
                                        color: mainColorBlack,
                                        fontSize: 16,
                                        fontFamily: mainFontbold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
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
                                    child: Row(
                                      children: [
                                        Text(
                                          "View All".tr,
                                          style: TextStyle(color: mainColorRed),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getHeight(context, 1),
                              ),
                              listItemsSmall(context,
                                  productrovider.getProductsByDiscount(), true),
                            ],
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Highlight".tr,
                          style: TextStyle(
                              color: mainColorBlack,
                              fontSize: 16,
                              fontFamily: mainFontbold),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (productrovider.show) {
                              productrovider.settype("Highlight");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllItem()),
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "View All".tr,
                                style: TextStyle(color: mainColorRed),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    listItemsSmall(context,
                        productrovider.getProductsByHighlight(), false),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Brands".tr,
                          style: TextStyle(
                              color: mainColorBlack,
                              fontSize: 16,
                              fontFamily: mainFontbold),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (productrovider.show) {
                                  productrovider.settype("best");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const allBrands()),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All".tr,
                                    style: TextStyle(color: mainColorRed),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    listitemsBrands(context, productrovider.brands),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    // Best Seller
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best Sell".tr,
                          style: TextStyle(
                              color: mainColorBlack,
                              fontSize: 16,
                              fontFamily: mainFontbold),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (productrovider.show) {
                                  productrovider.settype("best");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AllItem()),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All".tr,
                                    style: TextStyle(color: mainColorRed),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    listItemsSmall(
                        context, productrovider.getProductsByBestsell(), false),

                    // Space
                    SizedBox(
                      height: getHeight(context, 2),
                    ),

                    Visibility(
                      visible: productrovider.show,
                      replacement: Skeletonizer(
                        effect: ShimmerEffect.raw(colors: [
                          mainColorGrey.withOpacity(0.1),
                          mainColorWhite,
                          // mainColorRed.withOpacity(0.1),
                        ]),
                        child: Container(
                            height: getHeight(context, 22),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/Reklam.jpg",
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                      child: productrovider.tops.isEmpty
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () {
                                productrovider.settype("brand");
                                productrovider.setidbrand(
                                    productrovider.tops.first.brandId!);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AllItem()),
                                );
                              },
                              child: Container(
                                  height: getHeight(context, 22),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: dotenv.env['imageUrlServer']! +
                                          productrovider.tops.first.imgEn!,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              "assets/images/Logo-Type-2.png"),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/Logo-Type-2.png"),
                                      filterQuality: FilterQuality.low,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ),
                    ),
                    // Space
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> _homePopup(
    BuildContext context,
    String type,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final productrovider =
            Provider.of<productProvider>(context, listen: false);
        return AlertDialog(
          actionsPadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          content: Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Stack(
              alignment: lang == "en" ? Alignment.topRight : Alignment.topLeft,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      width: getWidth(context, 100),
                      height: getHeight(context, 45),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          imageUrl: dotenv.env['imageUrlServer']! +
                              homePopupData["img"],
                          placeholder: (context, url) =>
                              Image.asset("assets/images/Logo-Type-2.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/Logo-Type-2.png"),
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    FadeInUp(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextButton(
                          onPressed: () async {
                            if (homePopupData["type"] == "attention") {
                              Navigator.pop(context);
                            } else if (homePopupData["type"] == "brand") {
                              productrovider.settype("brand");
                              productrovider
                                  .setidbrand(homePopupData["brand_id"]);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllItem()),
                              );
                            } else if (homePopupData["type"] == "discount") {
                              productrovider.settype("discount");
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllItem()),
                              );
                            } else if (homePopupData["type"] == "onItem") {
                              print(homePopupData["barcode"]);
                              productrovider.setidItem(productrovider
                                  .getoneProductByBarcode(
                                      homePopupData["barcode"])
                                  .id!);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(color: 5)),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            fixedSize: Size(
                                getWidth(context, 45), getHeight(context, 5)),
                          ),
                          //checkText
                          child: Text(
                            type != "pop"
                                ? "Update".tr
                                : homePopupData["type"] == "attention"
                                    ? "OK".tr
                                    : "tap View".tr,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: mainColorRed,
                      size: 35,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> locationempty() {
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => Directionality(
        textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {},
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            final productrovider =
                Provider.of<productProvider>(context, listen: true);
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: getWidth(context, 100),
                  height: productrovider.location.isEmpty
                      ? getHeight(context, 40)
                      : getHeight(context, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      productrovider.location.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: getHeight(context, 5),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    LocationPermission permission =
                                        await Geolocator.requestPermission();
                                    if (permission ==
                                        LocationPermission.denied) {
                                      // Handle case where the user denied access to their location
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Map_screen()),
                                    );
                                  },
                                  child: SizedBox(
                                    width: getWidth(context, 100),
                                    height: getHeight(context, 15),
                                    child: Image.asset(lang == "en"
                                        ? "assets/Victors/location.png"
                                        : lang == "ar"
                                            ? "assets/Victors/locationAr.png"
                                            : "assets/Victors/locationKu.png"),
                                  ),
                                ),
                                SizedBox(
                                  height: getHeight(context, 5),
                                ),
                              ],
                            )
                          : Container(
                              width: getWidth(context, 100),
                              height: getHeight(context, 35),
                              child: ListView.builder(
                                  itemCount: productrovider.location.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final location = productrovider
                                        .location.reversed
                                        .toList()[index];

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color:
                                                mainColorGrey.withOpacity(0.5),
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            if (productrovider.defultlocation ==
                                                location.id!) {
                                            } else {
                                              mystate(() {
                                                productrovider
                                                    .setdefultlocation(
                                                        location.id!);
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                          title: Text(
                                            location.name!,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: mainFontbold,
                                                color: mainColorBlack,
                                                fontSize: 16),
                                          ),
                                          subtitle: Text(
                                            location.area!,
                                            style: TextStyle(
                                                fontFamily: mainFontnormal,
                                                color: mainColorGrey,
                                                fontSize: 12),
                                          ),
                                          trailing: Icon(
                                            productrovider.defultlocation ==
                                                    location.id!
                                                ? Icons.check_box
                                                : Icons.check_box_outline_blank,
                                            color: mainColorGrey,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                      TextButton(
                        onPressed: () async {
                          LocationPermission permission =
                              await Geolocator.requestPermission();
                          if (permission == LocationPermission.denied) {
                            // Handle case where the user denied access to their location
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Map_screen()),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: productrovider.location.length > 0
                              ? mainColorGrey
                              : mainColorRed,
                          fixedSize: Size(
                              getWidth(context, 70), getHeight(context, 5)),
                        ),
                        child: Text(
                          "Add location".tr,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 65,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: mainColorGrey,
                      ),
                    ))
              ],
            );
          }),
        ),
      ),
    ).then((value) {});
  }

  void feedbackmMdal(BuildContext context, productProvider pro) {
    showModalBottomSheet(
      backgroundColor: mainColorWhite,
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: isExpanded
                    ? MediaQuery.of(context).size.height - 150
                    : MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Directionality(
                        textDirection: lang == "en"
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Stack(
                              alignment: lang == "en"
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: getHeight(context, 4),
                                    ),
                                    Image.asset(
                                      'assets/images/Dlly Las Main.png',
                                      width: getWidth(context, 35),
                                    ),

                                    SizedBox(
                                      height: getHeight(context, 2),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(context, 6)),
                                      child: Text(
                                        "rating detail text".tr,
                                        style: TextStyle(
                                          color: mainColorBlack,
                                          fontFamily: mainFontnormal,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                    SizedBox(
                                      height: getHeight(context, 2),
                                    ),

                                    // Rating
                                    RatingBar(
                                      filledIcon: LineIcons.starAlt,
                                      emptyIcon: LineIcons.star,
                                      key: Key(
                                          'rating_bar'), // Adding the key here
                                      onRatingChanged: (value) {
                                        setState(() {
                                          selectedRating = int.parse(
                                              value.toString().substring(0, 1));
                                          isExpanded = true;
                                          // selectedWords.clear();
                                          // displayedWords = getDisplayedWords(value);
                                        });
                                      },

                                      initialRating: 0,
                                      alignment: Alignment.center,
                                      // filledColor: mainColorRed,
                                      // emptyColor: mainColorRed,
                                      size: 50,
                                    ),
                                    SizedBox(
                                      height: getHeight(context, 2),
                                    ),
                                    isExpanded
                                        ? Text(
                                            ratestar[selectedRating! - 1].tr,
                                            style: TextStyle(
                                              color: mainColorBlack,
                                              fontFamily: mainFontnormal,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        : SizedBox(),
                                    isExpanded
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: getHeight(context, 3),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                                child: TextFormField(
                                                  maxLines: 5,
                                                  controller:
                                                      feedbackController,
                                                  cursorColor: mainColorGrey,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onChanged: (value) {},
                                                  validator: (value) {
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        color:
                                                            mainColorGrey, // Customize border color
                                                        width:
                                                            1.0, // Customize border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        color: mainColorGrey
                                                            .withOpacity(
                                                                0.5), // Customize border color
                                                        width:
                                                            1.0, // Customize border width
                                                      ),
                                                    ),
                                                    labelText: "Feedback".tr,
                                                    labelStyle: TextStyle(
                                                        color: mainColorGrey
                                                            .withOpacity(0.8),
                                                        fontSize: 20,
                                                        fontFamily:
                                                            mainFontbold),
                                                    hintText:
                                                        "Add your Feedback".tr,
                                                    hintStyle: TextStyle(
                                                        color: mainColorBlack
                                                            .withOpacity(0.5),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            mainFontnormal),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: getHeight(context, 20),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getWidth(context, 4)),
                                                child: TextButton(
                                                  onPressed: () async {
                                                    var data = {
                                                      "oid": pro.Orders.last.id,
                                                      "feedback":
                                                          feedbackController
                                                              .text,
                                                      "rating": selectedRating
                                                    };
                                                    Network(false)
                                                        .postData(
                                                            "orderFeedback",
                                                            data,
                                                            context)
                                                        .then((value) {
                                                      if (value != "") {
                                                        if (value["code"] ==
                                                            "201") {
                                                          setState(() {
                                                            waitingFeedback =
                                                                true;
                                                            pro.Orders.last
                                                                    .rating =
                                                                selectedRating;
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        } else {
                                                          setState(() {
                                                            waitingFeedback =
                                                                false;
                                                          });
                                                        }
                                                      } else {
                                                        setState(() {
                                                          waitingFeedback =
                                                              false;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  style: TextButton.styleFrom(
                                                    fixedSize: Size(
                                                        getWidth(context, 90),
                                                        getHeight(context, 6)),
                                                  ),
                                                  child: Text(
                                                    "Send Feedback".tr,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: mainColorGrey,
                                        size: 30,
                                      )),
                                )
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: 65,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: mainColorGrey,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    waitingFeedback
                        ? Center(child: waitingWiget(context))
                        : SizedBox(),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      if (!waitingFeedback) {
        var data = {"oid": pro.Orders.last.id, "feedback": "", "rating": -1};
        Network(false).postData("orderFeedback", data, context).then((value) {
          if (value != "") {
            if (value["code"] == "201") {
              setState(() {
                pro.Orders.last.rating = -1;
              });
            }
          }
        });
      }
      setState(() {
        isExpanded = false;
        feedbackController.clear();
        // selectedWords.clear();
        selectedRating = 0;
        // displayedWords.clear();
      });
    });
  }
}
