// Import necessary packages and libraries
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dllylas/home/DetailsPage.dart';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Landing/choose_lan.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/all_item.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/Order/track_order.dart';
import 'package:dllylas/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dllylas/model/order_model/order_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Config/property.dart';
import '../home/nav_switch.dart';

/// A screen displayed when the app starts, handling various initializations,
/// including connectivity checks, platform-specific updates, and navigation
/// based on remote messages.
class SplashScreen extends StatefulWidget {
  /// An optional [RemoteMessage] to handle specific actions.
  final RemoteMessage? message;

  /// Constructs a [SplashScreen] with an optional [RemoteMessage].
  SplashScreen({RemoteMessage? message, Key? key})
      : message = message ?? RemoteMessage(),
        super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Global variables for various data
var vouchernow = {};
var userdata = {};
var homePopupData = {};

// Flags for data loading and home popup state
bool loaddata = false;
bool seenHomepopup = false;

class _SplashScreenState extends State<SplashScreen> {
  bool seen = false;
  bool textshow = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool check = true;

  @override
  void initState() {
    super.initState();
    checkinternet();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    FirebaseFirestore.instance
        .collection("onLoad")
        .doc("1")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get("show") == true) {
          setState(() {
            check = false;
          });
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
                  (value == "ios" && documentSnapshot.get("isAccpetApple"))) {
                setState(() {
                  check = false;
                });
                _homePopup(context, value);
              }
            }
          });
        }
      }
    });
  }

  /// Updates the connection status and performs actions based on internet availability.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final pro = Provider.of<productProvider>(context, listen: false);
    if (result[0] == ConnectivityResult.none) {
      pro.setnointernetcheck(true);
      setState(() {
        textshow = true;
      });
    } else {
      Provider.of<productProvider>(context, listen: false).getDataAll(false);
      if (pro.nointernetCheck) {
        setState(() {
          pro.setnointernetcheck(false);
          setState(() {
            textshow = false;
          });
        });

        getStringPrefs("data").then((map) {
          if (map.isNotEmpty) {
            Map<String, dynamic> myMap = json.decode(map);

            seen = myMap["onbord"];
            isLogin = myMap.containsKey("islogin") ? myMap["islogin"] : false;
            token =
                myMap.containsKey("token") ? decryptAES(myMap["token"]) : "";
          }

          pro.updatePost(isLogin);
        });

        Timer(
          const Duration(seconds: 6),
          () {
            navigator(context);
          },
        );
      }
    }
  }

  /// Navigates to a different screen based on the type of remote message.
  void navigator(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: false);

    if (widget.message!.data.isEmpty) {
      final String? id = Get.parameters['id'];
      if (id != null) {
        productrovider.setidItem(int.parse(id));
        Navigator.of(context)
            .pushReplacement(
          MaterialPageRoute(builder: (context) => DetailsPage(color: 5)),
        )
            .then((value) {
          Get.toNamed("/home");
        });
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => seen ? NavSwitch() : const ChooseLang(),
          ),
        );
      }
    }
    if ('onItem' == widget.message!.data["type"]) {
      productrovider.setidItem(productrovider
          .getoneProductByBarcode(widget.message!.data["subrelation"])
          .id!);
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(builder: (context) => DetailsPage(color: 5)),
      )
          .then((value) {
        Get.toNamed("/home");
      });
    } else if ('discount' == widget.message!.data["type"]) {
      productrovider.settype("discount");
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(builder: (context) => const AllItem()),
      )
          .then((value) {
        Get.toNamed("/home");
      });
    } else if ('brand' == widget.message!.data["type"]) {
      productrovider.settype("brand");

      productrovider
          .setidbrand(int.parse(widget.message!.data["relationId"].toString()));
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(builder: (context) => const AllItem()),
      )
          .then((value) {
        Get.toNamed("/home");
      });
    } else if ('category' == widget.message!.data["type"]) {
      if (productrovider.categores.indexWhere((category) =>
              category.id ==
              int.parse(widget.message!.data["relationId"].toString())) ==
          -1) {
        return;
      }
      productrovider.setcatetype(
          int.parse(widget.message!.data["relationId"].toString()));
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(builder: (context) => itemCategories()),
      )
          .then((value) {
        productrovider.setsubcateSelect(0);
        Get.toNamed("/home");
      });
    } else if ('subcategory' == widget.message!.data["type"]) {
      if (productrovider.categores.indexWhere((category) =>
                  category.id ==
                  int.parse(widget.message!.data["relationId"].toString())) ==
              -1 ||
          productrovider.subCategores.indexWhere((subCategory) =>
                  subCategory.id ==
                  int.parse(widget.message!.data["subrelation"])) ==
              -1) {
        return;
      }
      productrovider.setcatetype(
          int.parse(widget.message!.data["relationId"].toString()));
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(
            builder: (context) => itemCategories(
                  subcateID: int.parse(widget.message!.data["subrelation"]),
                )),
      )
          .then((value) {
        productrovider.setsubcateSelect(0);
        Get.toNamed("/home");
      });
    } else if ('order' == widget.message!.data["type"]) {
      OrderModel order = productrovider.Orders.firstWhere((element) =>
          element.id ==
          int.parse(widget.message!.data["relationId"].toString()));
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(
            builder: (context) => TrackOrder(
                  order.id!,
                )),
      )
          .then((value) {
        productrovider.setsubcateSelect(0);
        Get.toNamed("/home");
      });
    } else if ('attention' == widget.message!.data["type"]) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => seen ? NavSwitch() : const ChooseLang(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  /// Checks internet connectivity and performs actions based on availability.
  Future<void> checkinternet() async {
    final pro = Provider.of<productProvider>(context, listen: false);
    if (await noInternet(context)) {
      setState(() {
        pro.setnointernetcheck(true);
        textshow = true;
      });
      return;
    }

    setState(() {
      pro.setnointernetcheck(false);
      textshow = false;
    });
    getStringPrefs("data").then((map) {
      if (map.isNotEmpty) {
        Map<String, dynamic> myMap = json.decode(map);

        seen = myMap["onbord"];
        isLogin = myMap.containsKey("islogin") ? myMap["islogin"] : false;
        token = myMap.containsKey("token") ? decryptAES(myMap["token"]) : "";
      }

      pro.updatePost(isLogin);
    });

    Timer(
      const Duration(seconds: 6),
      () {
        if (check) {
          navigator(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return textshow
        ? noInternetWidget(context) // Displays a widget when there's no internet
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              body: Center(
                child: Image.asset(
                  mainImageLogo1, // Displays the app logo
                  width: getWidth(context, 100),
                ),
              ),
            ),
          );
  }

  /// Shows an informational dialog with a title, content, and button.
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
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {},
          child: AlertDialog(
            content: Directionality(
              textDirection:
                  lang == "en" ? TextDirection.ltr : TextDirection.rtl,
              child: Stack(
                alignment:
                    lang == "en" ? Alignment.topLeft : Alignment.topRight,
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
                          content.tr,
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
                            exit(0); // Exits the app when the button is pressed
                          },
                          style: TextButton.styleFrom(
                            fixedSize: Size(
                                getWidth(context, 70), getHeight(context, 5)),
                          ),
                          child: Text(
                            buttontxt.tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Displays a home popup dialog with a specific image and update button.
  Future<void> _homePopup(
    BuildContext context,
    String type,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final productrovider =
            Provider.of<productProvider>(context, listen: false);
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {},
          child: AlertDialog(
            actionsPadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: Directionality(
              textDirection:
                  lang == "en" ? TextDirection.ltr : TextDirection.rtl,
              child: SizedBox(
                width: getWidth(context, 100),
                height: getHeight(context, 50),
                child: Column(
                  children: [
                    SizedBox(
                      width: getWidth(context, 100),
                      height: getHeight(context, 40),
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
                    SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextButton(
                          onPressed: () async {
                            if (type == "huawei") {
                              Uri url = Uri.parse(
                                  'https://appgallery.huawei.com/app/C109952685');
                              if (!await launchUrl(url,
                                  mode: LaunchMode.externalApplication)) {
                                throw Exception("Could not launch".tr + "$url");
                              }
                            } else if (type == "android") {
                              Uri url = Uri.parse(
                                  'https://play.google.com/store/apps/details?id=com.market.dllylas');
                              if (!await launchUrl(url,
                                  mode: LaunchMode.externalApplication)) {
                                throw Exception("Could not launch".tr + "$url");
                              }
                            } else {
                              Uri url = Uri.parse(
                                  'https://apps.apple.com/iq/app/dlly-las-market/id6474247014');
                              if (!await launchUrl(url,
                                  mode: LaunchMode.externalApplication)) {
                                throw Exception("Could not launch".tr + "$url");
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                            fixedSize: Size(
                                getWidth(context, 45), getHeight(context, 5)),
                          ),
                          child: Text(
                            "Update".tr,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Checks the platform and determines whether to return "huawei", "android", or "ios".
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
}
