// Import necessary packages and libraries
import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import '../Landing/splash_screen.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:huawei_push/huawei_push.dart';
import 'package:provider/provider.dart';
import '../home/nav_switch.dart';

/// This class represents the sign-in/up screen of the application.
/// It allows users to complete their account setup by providing additional details.
class SingInUp extends StatefulWidget {
  final String phone_number;
  final String isNotApprove;
  final String token_user;

  /// Constructor for [SingInUp] widget.
  /// [phone_number]: The phone number associated with the user.
  /// [isNotApprove]: Indicates if the account is not approved.
  /// [token_user]: The token of the user.
  SingInUp(this.phone_number, this.isNotApprove, this.token_user, {super.key});

  @override
  State<SingInUp> createState() => _SingInUpState();
}

class _SingInUpState extends State<SingInUp> {
  bool _isLoading = false; // Tracks if the app is in loading state

  String gender = ""; // Holds the selected gender
  List<String> items = [
    'Erbil',
    'Sulaymaniyah',
    'Duhok',
    'Halabja'
  ]; // List of cities
  String city = "Erbil"; // Default city
  bool nameE = false; // Indicates if there is a name error
  bool ageE = false; // Indicates if there is an age error
  bool cityE = false; // Indicates if there is a city error
  bool genderE = false; // Indicates if there is a gender error
  String token2 = ""; // Token for push notifications
  TextEditingController nameController =
      TextEditingController(); // Controller for name input
  TextEditingController age =
      TextEditingController(); // Controller for age input
  static final DeviceInfoPlugin deviceInfoPlugin =
      DeviceInfoPlugin(); // Device info plugin instance

  @override
  void initState() {
    super.initState();
    gettokenDevices(); // Fetches device token
  }

  /// Retrieves the device token for push notifications.
  /// It handles different cases for Android and iOS devices.
  Future<void> gettokenDevices() async {
    if (Platform.isAndroid) {
      String check = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      if (check.toLowerCase() == "HUAWEI".toLowerCase()) {
        Push.enableLogger(); // Enables logging for Huawei push notifications
        Push.disableLogger(); // Disables logging
        initPlatformState(); // Initializes platform-specific push settings
        Push.getToken(''); // Retrieves Huawei push token
      } else {
        // Retrieves Firebase push token for non-Huawei Android devices
        FirebaseMessaging.instance.getToken().then((val) async {
          token2 = val.toString();
        });
      }
    } else {
      // Retrieves Firebase push token for iOS devices
      FirebaseMessaging.instance.getToken().then((val) async {
        token2 = val.toString();
      });
    }
  }

  /// Initializes platform-specific push notification settings.
  /// This method is called when the device is running on Huawei.
  Future<void> initPlatformState() async {
    if (!mounted) return; // Ensures the widget is still mounted
    await Push.setAutoInitEnabled(
        true); // Enables auto-initialization for Huawei push notifications

    // Listens for token updates from Huawei push notifications
    Push.getTokenStream.listen(
      _onTokenEvent,
      onError: _onTokenError,
    );
  }

  /// Handles the event when a new push notification token is received.
  /// [event]: The new token received.
  void _onTokenEvent(String event) {
    token2 = event; // Updates the token
  }

  /// Handles errors that occur while receiving push notification tokens.
  /// [error]: The error that occurred.
  void _onTokenError(Object error) {
    PlatformException e =
        error as PlatformException; // Casts error to PlatformException
  }

  @override

  /// Builds the UI for the Sign-In/Sign-Up screen.
  /// This method constructs a form where users can complete their account setup.
  /// The layout includes fields for name, age, city, and gender, with validation and animations.
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite, // Background color of the screen
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColorWhite, // AppBar background color
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // Navigates back to the previous screen
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColorGrey, // Color of the back arrow icon
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(
                  getHeight(context, 3)), // Padding around the container
              width: getWidth(context, 100), // Width of the container
              child: Column(
                children: [
                  // Title of the screen with animation
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      "Complete Account".tr, // Translated title
                      style: TextStyle(
                        color: mainColorBlack,
                        fontSize: 30,
                        fontFamily: mainFontbold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 1), // Spacing between elements
                  ),
                  // Subtitle of the screen with animation
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      "Enter your account information to complete your account"
                          .tr, // Translated subtitle
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mainColorBlack,
                        fontFamily: mainFontnormal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 4), // Spacing between elements
                  ),
                  // Name input field with animation
                  FadeInDown(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: TextFormField(
                      controller: nameController,
                      cursorColor: mainColorGrey, // Color of the cursor
                      keyboardType: TextInputType.text, // Type of keyboard
                      onChanged: (value) {
                        setState(() {
                          nameE =
                              false; // Resets name error state on input change
                        });
                      },
                      validator: (value) {
                        return null; // Validation logic (currently none)
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorGrey, // Border color when focused
                            width: 1.0, // Border width when focused
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: mainColorGrey
                                .withOpacity(0.5), // Border color when enabled
                            width: 1.0, // Border width when enabled
                          ),
                        ),
                        labelText: "Name".tr, // Translated label text
                        labelStyle: TextStyle(
                          color: mainColorBlack.withOpacity(0.8),
                          fontSize: 18,
                          fontFamily: mainFontbold,
                        ),
                        hintText: "Enter your Name".tr, // Translated hint text
                        hintStyle: TextStyle(
                          color: mainColorBlack.withOpacity(0.5),
                          fontSize: 14,
                          fontFamily: mainFontnormal,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                  // Displays an error message if nameE is true
                  nameE
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: getHeight(context, 0.5),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.circleInfo,
                                color: mainColorRed.withOpacity(0.7),
                                size: 15,
                              ),
                              SizedBox(
                                width: getWidth(context, 1),
                              ),
                              Text(
                                "Enter your full name"
                                    .tr, // Translated error message
                                style: TextStyle(
                                  fontFamily: mainFontbold,
                                  color: mainColorRed.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: getHeight(context, 3), // Spacing between elements
                  ),
                  // City dropdown field with animation
                  FadeInDown(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 500),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColorGrey.withOpacity(
                                    0.5), // Border color when enabled
                                width: 1.0, // Border width when enabled
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: "City".tr, // Translated label text
                            labelStyle: TextStyle(
                              color: mainColorBlack,
                              fontSize: 18,
                              fontFamily: mainFontbold,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColorBlack
                                    .withOpacity(0.5), // Border color
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: city,
                              isDense: true,
                              onChanged: true
                                  ? null
                                  : (value) {
                                      setState(() {
                                        city = value
                                            .toString(); // Updates city on selection
                                      });
                                    },
                              items: items.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value.tr, // Translated city name
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: mainFontnormal,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 3), // Spacing between elements
                  ),
                  // Age input field with animation
                  FadeInDown(
                    delay: const Duration(milliseconds: 700),
                    duration: const Duration(milliseconds: 500),
                    child: TextFormField(
                      controller: age,
                      cursorColor: mainColorGrey, // Color of the cursor
                      keyboardType: TextInputType.number, // Type of keyboard
                      onChanged: (value) {
                        setState(() {
                          ageE =
                              false; // Resets age error state on input change
                        });
                      },
                      validator: (value) {
                        return null; // Validation logic (currently none)
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: mainColorGrey, // Border color when focused
                            width: 1.0, // Border width when focused
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: mainColorGrey
                                .withOpacity(0.5), // Border color when enabled
                            width: 1.0, // Border width when enabled
                          ),
                        ),
                        labelText: "Age".tr, // Translated label text
                        labelStyle: TextStyle(
                          color: mainColorBlack.withOpacity(0.8),
                          fontSize: 18,
                          fontFamily: mainFontbold,
                        ),
                        hintText: "Enter your age".tr, // Translated hint text
                        hintStyle: TextStyle(
                          color: mainColorBlack.withOpacity(0.5),
                          fontSize: 14,
                          fontFamily: mainFontnormal,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                  // Displays an error message if ageE is true
                  ageE
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: getHeight(context, 0.5),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.circleInfo,
                                color: mainColorRed.withOpacity(0.7),
                                size: 15,
                              ),
                              SizedBox(
                                width: getWidth(context, 1),
                              ),
                              Text(
                                "please, Enter the number only"
                                    .tr, // Translated error message
                                style: TextStyle(
                                  fontFamily: mainFontbold,
                                  color: mainColorRed.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: getHeight(context, 2), // Spacing between elements
                  ),
                  // Gender picker widget with animation
                  FadeInDown(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 500),
                    child: _genderWidget(true, false),
                  ),
                  SizedBox(
                    height: getHeight(
                        context, 15), // Spacing before the confirm button
                  ),
                  // Confirm button with animation and loading indicator
                  FadeInDown(
                    delay: const Duration(milliseconds: 900),
                    duration: const Duration(milliseconds: 500),
                    child: TextButton(
                      onPressed: () async {
                        if (nameController.text.isEmpty) {
                          setState(() {
                            nameE = true;
                          });
                          return;
                        }

                        if (gender == "") {
                          gender = "Gender";
                        }
                        if (age.text == "") {
                          age.text = 0.toString();
                        } else {
                          if (!containsOnlyNumbers(age.text)) {
                            setState(() {
                              ageE = true;
                            });
                            return;
                          }
                        }

                        setState(() {
                          _isLoading = true;
                        });
                        var data = {
                          "phone": widget.phone_number,
                          "name": nameController.text,
                          "city": city == "Select City" ? "Erbil" : city,
                          "age": age.text.toString(),
                          "gender": gender,
                          "img": gender == "Gender"
                              ? "storage/profile/gender.png"
                              : gender == "Male"
                                  ? "storage/profile/Man.png"
                                  : "storage/profile/Woman.png",
                          "fcmToken": token2,
                          "device": Platform.isAndroid
                              ? _readAndroidBuildData(
                                      await deviceInfoPlugin.androidInfo)
                                  .toString()
                              : _readIosDeviceInfo(
                                  await deviceInfoPlugin.iosInfo),
                          "platform": Platform.isAndroid ? "android" : "ios",
                          "password": "jhiji",
                        };

                        try {
                          Network(false)
                              .updateUserTemp("updateUserTempData", data,
                                  context, widget.token_user)
                              .then((value) {
                            if (value != "") {
                              if (value["code"] == "200") {
                                if (widget.isNotApprove == "true") {
                                  setState(() {
                                    _isLoading = false;
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    //textcheck
                                                    Image.asset(
                                                      "assets/Victors/pendding.png",
                                                      width:
                                                          getWidth(context, 40),
                                                      height:
                                                          getWidth(context, 40),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Account Pendding".tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: mainColorGrey,
                                                        fontFamily:
                                                            mainFontbold,
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      "Account npt approved by admin yet"
                                                          .tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: mainColorGrey,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NavSwitch()),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        fixedSize: Size(
                                                            getWidth(
                                                                context, 70),
                                                            getHeight(
                                                                context, 5)),
                                                      ),
                                                      child: Text(
                                                        "OK".tr,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.close))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  return;
                                }
                                setState(() {
                                  _isLoading = false;
                                  isLogin = true;
                                  loaddata = false;
                                  token = decryptAES(widget.token_user);
                                });
                                getStringPrefs("data").then((map) {
                                  Map<String, dynamic> myMap = json.decode(map);
                                  myMap["islogin"] = true;
                                  myMap["token"] = widget.token_user;
                                  setStringPrefs("data", json.encode(myMap));
                                });

                                final productrovider =
                                    Provider.of<productProvider>(context,
                                        listen: false);
                                productrovider.updatePost(true);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavSwitch()),
                                );
                              }
                            } else {
                              toastShort(
                                  "unknown occurred error please try again later"
                                      .tr);
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          });
                        } catch (e) {
                          toastShort(
                              "unknown occurred error please try again later"
                                  .tr);
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                          fixedSize: Size(
                              getWidth(context, 100), getHeight(context, 6))),
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                backgroundColor: mainColorWhite,
                                color: mainColorGrey,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "Confirm".tr,
                            ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  /// Retrieves the manufacturer of the Android device.
  ///
  /// [build] contains information about the Android device.
  /// Returns a string representing the manufacturer of the device.
  String _readAndroidBuildData(AndroidDeviceInfo build) {
    return build
        .manufacturer; // Returns the manufacturer name of the Android device
  }

  /// Retrieves the name of the iOS device.
  ///
  /// [data] contains information about the iOS device.
  /// Returns a string representing the name of the device.
  String _readIosDeviceInfo(IosDeviceInfo data) {
    return data.name; // Returns the name of the iOS device
  }

  /// Checks if the given text contains only numeric characters.
  ///
  /// [text] is the string to be checked.
  /// Returns true if [text] contains only numbers, false otherwise.
  bool containsOnlyNumbers(String text) {
    final RegExp numberRegex =
        RegExp(r'^[0-9]+$'); // Regex pattern for numeric values
    return numberRegex.hasMatch(text); // Checks if the text matches the pattern
  }

  /// Constructs a widget for selecting gender with images.
  ///
  /// [showOther] indicates whether to show additional options.
  /// [alignment] determines the alignment of the text within the widget.
  /// Returns a [Widget] for gender selection.
  Widget _genderWidget(bool showOther, bool alignment) {
    return Container(
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        verticalAlignedText: alignment, // Aligns text vertically
        onChanged: (value) {
          final split =
              value.toString().split('.'); // Splits the value to extract gender
          gender = split[1]; // Sets the gender based on the selected value
        },
        selectedGenderTextStyle: TextStyle(
          fontFamily: mainFontnormal, // Style for selected gender text
        ),
        unSelectedGenderTextStyle: TextStyle(
          fontFamily: mainFontnormal, // Style for unselected gender text
        ),
        maleText: "Male".tr, // Translated text for male option
        femaleText: "Female".tr, // Translated text for female option
        selectedGender: gender == "Male"
            ? Gender.Male // Sets selected gender to Male if gender is "Male"
            : gender == ""
                ? null // No selection if gender is empty
                : Gender.Female, // Sets selected gender to Female by default
        equallyAligned: true, // Aligns gender options equally
        size: 70.0, // Size of the gender picker
        animationDuration: const Duration(seconds: 1), // Duration of animation
        isCircular: true, // Circular shape for the picker
        opacityOfGradient: 0.5, // Opacity of the gradient effect
        padding: const EdgeInsets.all(8.0), // Padding around the gender picker
      ),
    );
  }
}
