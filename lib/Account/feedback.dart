// Import necessary packages and libraries
import 'dart:io';  
import 'package:custom_rating_bar/custom_rating_bar.dart'; 
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Network/Network.dart';
import '../Landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Config/property.dart';

/// A StatefulWidget that provides a screen for users to submit feedback and rate the app.
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  /// Determines the app store to direct users to based on the platform and manufacturer.
  Future<String> checkPlatformAndLaunchUrl() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    // Check if the platform is Android
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      String manufacturer = androidInfo.manufacturer;

      // Return app store based on the manufacturer
      if (manufacturer.toLowerCase() == "huawei") {
        return "AppGallery";
      } else {
        return "Google Play";
      }
    } else {
      // Return App Store for iOS
      return "App Store";
    }
  }

  String typeStore = "";  // Store the type of app store
  bool waitingFeedback = false;  // Flag to indicate if feedback submission is in progress
  TextEditingController feedbackController = TextEditingController();  // Controller for feedback text field
  int? selectedRating = 0;  // Selected rating value
  bool Erating = false;  // Flag for rating validation error
  bool Efeedback = false;  // Flag for feedback validation error

  // List of rating descriptions
  List<String> ratestar = [
    "",
    'Terrible',
    'Poor',
    'Fair',
    'Good',
    'Excellent'
  ];

  @override
  void initState() {
    super.initState();
    // Determine the app store type when the screen initializes
    checkPlatformAndLaunchUrl().then((value) {
      setState(() {
        typeStore = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,  // Set text direction based on language
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Feedback".tr,  // Localized title for the app bar
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);  // Navigate back to the previous screen
            },
            icon: Icon(
              Icons.arrow_back_ios,  // Back arrow icon
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Directionality(
                  textDirection:
                      lang == "en" ? TextDirection.ltr : TextDirection.rtl,  // Set text direction based on language
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getHeight(context, 4),  // Top margin
                      ),
                      Text(
                        "Share your Feedback".tr,  // Localized text for the feedback prompt
                        style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontbold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getHeight(context, 2),  // Spacing between elements
                      ),
                      Image.asset(
                        'assets/Victors/disabled.png',  // Image asset for visual representation
                        width: getWidth(context, 50),  // Image width
                      ),
                      SizedBox(
                        height: getHeight(context, 4),  // Spacing between elements
                      ),
                      Text(
                        "Your feedback helps us improve".tr,  // Localized text for feedback importance
                        style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontnormal,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      RatingBar(
                        filledIcon: LineIcons.starAlt,  // Icon for filled rating stars
                        emptyIcon: LineIcons.star,  // Icon for empty rating stars
                        key: Key('rating_bar2'),
                        onRatingChanged: (value) {
                          setState(() {
                            // Update selected rating and clear rating error flag
                            selectedRating =
                                int.parse(value.toString().substring(0, 1));
                            Erating = false;
                          });
                        },
                        initialRating: 0,  // Initial rating value
                        alignment: Alignment.center,
                        size: 50,  // Size of the rating stars
                      ),
                      Erating
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: getHeight(context, 0.5),  // Padding for error message
                              ),
                              child: Text(
                                "Please select stars".tr,  // Localized error message
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: mainFontnormal,
                                  color: mainColorRed.withOpacity(0.8),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: getHeight(context, 2),  // Spacing between elements
                      ),
                      Text(
                        ratestar[selectedRating!].tr,  // Localized rating description based on selection
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
                            height: getHeight(context, 3),  // Spacing between elements
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              maxLines: 5,  // Allow multiple lines of text
                              controller: feedbackController,  // Controller for the text field
                              cursorColor: mainColorGrey,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  Efeedback = false;  // Clear feedback error flag on input change
                                });
                              },
                              validator: (value) {
                                return null;  // No additional validation
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Efeedback
                                        ? mainColorRed  // Error color when feedback is empty
                                        : mainColorGrey,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Efeedback
                                        ? mainColorRed
                                        : mainColorGrey.withOpacity(0.5),  // Lighter color when not focused
                                    width: 1.0,
                                  ),
                                ),
                                labelText: "Leave Your Comments".tr,  // Localized label text
                                labelStyle: TextStyle(
                                    color: Efeedback
                                        ? mainColorRed  // Error color when feedback is empty
                                        : mainColorGrey.withOpacity(0.8),
                                    fontSize: 20,
                                    fontFamily: mainFontbold),
                                hintText: Efeedback
                                    ? "Feedback is required".tr  // Localized hint text for empty feedback
                                    : "Add your Feedback".tr,  // Localized hint text for feedback input
                                hintStyle: TextStyle(
                                    color: mainColorBlack.withOpacity(0.5),
                                    fontSize: 14,
                                    fontFamily: mainFontnormal),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                        Center(child: waitingWiget(context)),  // Show waiting widget when feedback is being processed
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
              // Validate input fields
              if (selectedRating == 0) {
                setState(() {
                  Erating = true;  // Set rating error flag
                });
                return;
              }
              if (feedbackController.text.isEmpty) {
                setState(() {
                  Efeedback = true;  // Set feedback error flag
                });
                return;
              }
              
              // Prepare data for submission
              var data = {
                "id": userdata["id"],
                "feedback": feedbackController.text,
                "rating": selectedRating
              };
              
              // Submit feedback to the server
              Network(false)
                  .postData("userFeedback", data, context)
                  .then((value) {
                if (value != "") {
                  if (value["code"] == "201") {
                    setState(() {
                      waitingFeedback = false;  // Reset waiting flag
                      selectedRating = 0;  // Reset rating
                      feedbackController.clear();  // Clear feedback text
                    });
                    // Show dialog after successful feedback submission
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
                                        "assets/Victors/sure.png",  // Image asset for dialog
                                        width: getWidth(context, 40),
                                        height: getWidth(context, 40),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Enjoying the app?".tr,  // Localized text for dialog
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: mainColorBlack,
                                          fontFamily: mainFontbold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Would you mind rating us?".tr,  // Localized text for dialog
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: mainColorBlack,
                                          fontFamily: mainFontnormal,
                                          fontSize: 16,
                                        ),
                                      ),
                                      // Button to direct users to the app store
                                      TextButton(
                                        onPressed: () async {
                                          Uri url;
                                          // Launch URL based on app store type
                                          if (typeStore == "AppGallery") {
                                            url = Uri.parse(
                                                'https://appgallery.huawei.com/app/C109952685');
                                          } else if (typeStore ==
                                              "Google Play") {
                                            url = Uri.parse(
                                                'https://play.google.com/store/apps/details?id=com.market.dllylas');
                                          } else {
                                            url = Uri.parse(
                                                'https://apps.apple.com/iq/app/dlly-las-market/id6474247014');
                                          }
                                          if (!await launchUrl(url,
                                              mode: LaunchMode
                                                  .externalApplication)) {
                                            throw Exception(
                                                'Could not launch $url');
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          fixedSize: Size(getWidth(context, 70),
                                              getHeight(context, 5)),
                                        ),
                                        child: Text(
                                          "Rate us in".tr + " " + typeStore,  // Localized text for button
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      // Cancel button to close the dialog
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);  // Close the dialog
                                          Navigator.pop(context);  // Return to previous screen
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
                                // Close button for the dialog
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);  // Close the dialog
                                      Navigator.pop(context);  // Return to previous screen
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
                      waitingFeedback = false;  // Reset waiting flag if submission failed
                    });
                  }
                } else {
                  setState(() {
                    waitingFeedback = false;  // Reset waiting flag if submission failed
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
