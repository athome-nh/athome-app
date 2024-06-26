import 'dart:io';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Config/property.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Future<String> checkPlatformAndLaunchUrl() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      String manufacturer = androidInfo.manufacturer;

      if (manufacturer.toLowerCase() == "huawei") {
        return "AppGallery";
      } else {
        return "Google Play";
      }
    } else {
      return "App Store";
    }
  }

  String typeStore = "";
  bool waitingFeedback = false;
  TextEditingController feedbackController = TextEditingController();
  int? selectedRating = 0;
  bool Erating = false;
  bool Efeedback = false;
  List<String> ratestar = [
    "",
    'Poor',
    'Terrible',
    'Awful',
    'Unacceptable',
    'Dismal'
  ];
  @override
  void initState() {
    checkPlatformAndLaunchUrl().then((value) {
      typeStore = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Feedback".tr,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Directionality(
                  textDirection:
                      lang == "en" ? TextDirection.ltr : TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getHeight(context, 4),
                      ),
                      Text(
                        "Share your Feedback".tr,
                        style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontbold,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getHeight(context, 2),
                      ),
                      Image.asset(
                        'assets/Victors/disabled.png',
                        width: getWidth(context, 50),
                      ),
                      SizedBox(
                        height: getHeight(context, 4),
                      ),
                      Text(
                        "Your feedback helps us improve".tr,
                        style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontnormal,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      RatingBar(
                        filledIcon: LineIcons.starAlt,
                        emptyIcon: LineIcons.star,
                        key: Key('rating_bar2'),
                        onRatingChanged: (value) {
                          setState(() {
                            selectedRating =
                                int.parse(value.toString().substring(0, 1));
                            Erating = false;
                          });
                        },

                        initialRating: 0,
                        alignment: Alignment.center,
                        size: 50,
                      ),
                      Erating
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: getHeight(context, 0.5),
                              ),
                              child: Text(
                                "Please slecte stars".tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: mainFontnormal,
                                  color: mainColorRed.withOpacity(0.8),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: getHeight(context, 2),
                      ),
                      Text(
                        ratestar[selectedRating!].tr,
                        style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontnormal,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: getHeight(context, 3),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              maxLines: 5,
                              controller: feedbackController,
                              cursorColor: mainColorGrey,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  Efeedback = false;
                                });
                              },
                              validator: (value) {
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Efeedback
                                        ? mainColorRed
                                        : mainColorGrey, 
                                    width: 1.0, 
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Efeedback
                                        ? mainColorRed
                                        : mainColorGrey.withOpacity(
                                            0.5), 
                                    width: 1.0, 
                                  ),
                                ),
                                labelText: "Leave Your Comments".tr,
                                labelStyle: TextStyle(
                                    color: Efeedback
                                        ? mainColorRed
                                        : mainColorGrey.withOpacity(0.8),
                                    fontSize: 20,
                                    fontFamily: mainFontbold),
                                hintText: Efeedback
                                    ? "feedback is require".tr
                                    : "Add your Feedback".tr,
                                hintStyle: TextStyle(
                                    color: mainColorBlack.withOpacity(0.5),
                                    fontSize: 14,
                                    fontFamily: mainFontnormal),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              waitingFeedback
                  ? Column(
                      children: [
                        Center(child: waitingWiget(context)),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(getWidth(context, 4)),
          child: TextButton(
            onPressed: () async {
              if (selectedRating == 0) {
                setState(() {
                  Erating = true;
                });
                return;
              }
              if (feedbackController.text.isEmpty) {
                setState(() {
                  Efeedback = true;
                });
                return;
              }
              var data = {
                "id": userdata["id"],
                "feedback": feedbackController.text,
                "rating": selectedRating
              };
              Network(false)
                  .postData("userFeedback", data, context)
                  .then((value) {
                if (value != "") {
                  if (value["code"] == "201") {
                    setState(() {
                      waitingFeedback = false;
                      selectedRating = 0;
                      feedbackController.clear();
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Directionality(
                            textDirection: lang == "en"
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                            child: Stack(
                              alignment: lang == "en"
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              children: [
                                SizedBox(
                                  width: getWidth(context, 70),
                                  height: getHeight(context, 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/Victors/sure.png",
                                        width: getWidth(context, 40),
                                        height: getWidth(context, 40),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Enjoying the app?".tr,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: mainColorBlack,
                                          fontFamily: mainFontbold,
                                          fontSize: 25,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Would you mind rating us?".tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: mainColorBlack,
                                          fontFamily: mainFontnormal,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          if (typeStore == "AppGallery") {
                                            Uri url = Uri.parse(
                                                'https://appgallery.huawei.com/app/C109952685');
                                            if (!await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication)) {
                                              throw Exception(
                                                  'Could not launch $url');
                                            }
                                          } else if (typeStore ==
                                              "Google Play") {
                                            Uri url = Uri.parse(
                                                'https://play.google.com/store/apps/details?id=com.market.dllylas');
                                            if (!await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication)) {
                                              throw Exception(
                                                  'Could not launch $url');
                                            }
                                          } else {
                                            Uri url = Uri.parse(
                                                'https://apps.apple.com/iq/app/dlly-las-market/id6474247014');
                                            if (!await launchUrl(url,
                                                mode: LaunchMode
                                                    .externalApplication)) {
                                              throw Exception(
                                                  'Could not launch $url');
                                            }
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          fixedSize: Size(getWidth(context, 70),
                                              getHeight(context, 5)),
                                        ),
                                        child: Text(
                                          "Rate us in".tr + " " + typeStore,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          fixedSize: Size(getWidth(context, 70),
                                              getHeight(context, 5)),
                                          backgroundColor: mainColorRed,
                                        ),
                                        child: Text(
                                          "Cancel".tr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: mainColorBlack,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    setState(() {
                      waitingFeedback = false;
                    });
                  }
                } else {
                  setState(() {
                    waitingFeedback = false;
                  });
                }
              });
            },
            style: TextButton.styleFrom(
              fixedSize: Size(getWidth(context, 90), getHeight(context, 6)),
            ),
            child: Text(
              "Send Feedback".tr,
            ),
          ),
        ),
      ),
    );
  }
}
