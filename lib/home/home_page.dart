import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Home/all_item.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/Notifications/notification_page.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/home/oneitem.dart';

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
import 'package:flutter/widgets.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
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
                documentSnapshot.get("contenten"), "OK".tr, "error", "");
          } else if (lang == "ar") {
            ShowInfo(context, documentSnapshot.get("titlear"),
                documentSnapshot.get("contentar"), "OK".tr, "error", "");
          } else {
            ShowInfo(context, documentSnapshot.get("titleku"),
                documentSnapshot.get("contentku"), "OK".tr, "error", "");
          }
        } else {
          checkPlatformAndLaunchUrl().then((value) {
            if (dotenv.env['currentVersion']! !=
                documentSnapshot.get("newversion")) {
              if ((value == "huawei" &&
                      documentSnapshot.get("isAccpetHuawei")) ||
                  (value == "android" &&
                      documentSnapshot.get("isAccpetAndroid")) ||
                  (value == "ios" && documentSnapshot.get("isAccpetApple")))
                _homePopup(context, value);
            } else {
              final productrovider =
                  Provider.of<productProvider>(context, listen: false);
              if (isLogin &&
                  productrovider.Orders.last.status == 5 &&
                  productrovider.Orders.last.rating == null) {
                feedbackmMdal(context, productrovider);
              } else {
                if (!seenHomepopup) {
                  showhompopup();
                }
              }
            }
          });
        }
      }
    });

    checkinternet();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void showhompopup() {
    if (homePopupData["id"] != userdata["popupID"] ||
        homePopupData["isAlwaysShow"] == 1) {
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

  bool isExpanded = false;
  bool waitingFeedback = false;

  List<String> ratestar = [
    'Poor',
    'Terrible',
    'Awful',
    'Unacceptable',
    'Dismal'
  ];
  // List<String> oneStar = [
  //   'Poor',
  //   'Terrible',
  //   'Awful',
  //   'Unacceptable',
  //   'Dismal'
  // ];
  // List<String> twoStar = [
  //   'Below Average',
  //   'Mediocre',
  //   'Subpar',
  //   'Disappointing',
  //   'Unsatisfactory'
  // ];
  // List<String> threeStar = [
  //   'Average',
  //   'Decent',
  //   'Fair',
  //   'Okay',
  //   'Satisfactory'
  // ];
  // List<String> fourStar = [
  //   'Good',
  //   'Great',
  //   'Very Good',
  //   'Impressive',
  //   'Praiseworthy'
  // ];
  // List<String> fiveStar = [
  //   'Excellent',
  //   'Outstanding',
  //   'Exceptional',
  //   'Superb',
  //   'Flawless'
  // ];
  // List<String> getDisplayedWords(double i) {
  //   switch (i) {
  //     case 1:
  //       return oneStar;
  //     case 2:
  //       return twoStar;
  //     case 3:
  //       return threeStar;
  //     case 4:
  //       return fourStar;
  //     case 5:
  //       return fiveStar;
  //     default:
  //       return [];
  //   }
  // }

  // List<Widget> elem(StateSetter setState) {
  //   List<Widget> txt = [];

  //   for (var element in displayedWords) {
  //     bool isSelected = selectedWords.contains(element);
  //     txt.add(GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           if (isSelected) {
  //             isSelected = !isSelected;
  //             selectedWords.remove(element);
  //           } else {
  //             isSelected = !isSelected;
  //             selectedWords.add(element);
  //           }
  //         });
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: isSelected ? mainColorGrey : Colors.transparent,
  //             border:
  //                 Border.all(width: 1, color: mainColorBlack.withOpacity(0.5)),
  //             borderRadius: BorderRadius.circular(15)),
  //         margin: const EdgeInsets.only(
  //           top: 6,
  //           bottom: 6,
  //           left: 10,
  //           right: 10,
  //         ),
  //         padding: const EdgeInsets.only(
  //           left: 15,
  //           right: 15,
  //           bottom: 10,
  //           top: 10,
  //         ),
  //         child: Text(
  //           element,
  //           style: TextStyle(
  //             fontFamily: mainFontnormal,
  //             color:
  //                 isSelected ? mainColorWhite : mainColorBlack.withOpacity(0.5),
  //             fontSize: 12,
  //           ),
  //         ),
  //       ),
  //     ));
  //   }
  //   return txt;
  // }

  TextEditingController feedbackController = TextEditingController();
  // List<String> selectedWords = [];
  int? selectedRating;
  // List<String> displayedWords = [];
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
                                        isExpanded
                                            ? "Custom rating bar for flutter with support of: custom icons, half icons, directions, alignments & more."
                                                .tr
                                            : "Custom rating bar for flutter with support of: custom icons, half icons, directions, alignments & more."
                                                .tr,
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
                                            ratestar[selectedRating! - 1],
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
                                              // Wrap(
                                              //   alignment: WrapAlignment.center,
                                              //   children: elem(setState),
                                              // ),
                                              // SizedBox(
                                              //   height: getHeight(context, 4),
                                              // ),
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
                                                    labelText: "Feedback",
                                                    labelStyle: TextStyle(
                                                        color: mainColorGrey
                                                            .withOpacity(0.8),
                                                        fontSize: 20,
                                                        fontFamily:
                                                            mainFontbold),
                                                    hintText:
                                                        "Add your Feedback",
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
                                                    "Send Feedback",
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

  Future<String> checkPlatformAndLaunchUrl() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      String manufacturer = androidInfo.manufacturer;

      if (manufacturer.toLowerCase() == "huawei") {
        return "huawei";
      } else {
        return "android";
      }
    } else {
      return "ios";
    }
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
                          color: mainColorGrey,
                          size: 30,
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

  Future<void> ShowInfo(
    BuildContext context,
    String title,
    String content,
    String buttontxt,
    String type,
    String platform,
  ) {
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
                          exit(0);
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

  Future<void> _homePopup(
    BuildContext context,
    String type,
  ) {
    return showDialog(
      barrierDismissible: type == "pop",
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
                        child: type != "pop"
                            ? lang == "en"
                                ? Image.asset("assets/Victors/updateEN.png")
                                : lang == "ar"
                                    ? Image.asset("assets/Victors/updateAR.png")
                                    : Image.asset("assets/Victors/updateKU.png")
                            : CachedNetworkImage(
                                imageUrl: dotenv.env['imageUrlServer']! +
                                    homePopupData["img"],
                                // imageUrl:
                                //     "https://firebasestorage.googleapis.com/v0/b/dllylas-ec27d.appspot.com/o/DLly%20Las%20popo.jpg?alt=media&token=2a5ce41a-d3b6-4eb0-a43c-dff6fae351f6",
                                placeholder: (context, url) => Image.asset(
                                    "assets/images/Logo-Type-2.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        "assets/images/Logo-Type-2.png"),
                                filterQuality: FilterQuality.low,

                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    FadeInUp(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextButton(
                          onPressed: type != "pop"
                              ? () async {
                                  if (type == "huawei") {
                                    Uri url = Uri.parse(
                                        'https://appgallery.huawei.com/app/C109952685');
                                    if (!await launchUrl(url,
                                        mode: LaunchMode.externalApplication)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  } else if (type == "android") {
                                    Uri url = Uri.parse(
                                        'https://play.google.com/store/apps/details?id=com.market.dllylas');
                                    if (!await launchUrl(url,
                                        mode: LaunchMode.externalApplication)) {
                                      throw Exception('Could not launch $url');
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
                              : () async {
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
                                          builder: (context) =>
                                              const AllItem()),
                                    );
                                  } else if (homePopupData["type"] ==
                                      "discount") {
                                    productrovider.settype("discount");
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AllItem()),
                                    );
                                  } else if (homePopupData["type"] ==
                                      "onItem") {
                                    productrovider.setidItem(productrovider
                                        .getoneProductByBarcode(
                                            homePopupData["barcode"])
                                        .id!);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Oneitem()),
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
                                    : "tap View",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                type != "pop"
                    ? SizedBox()
                    : IconButton(
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
}
