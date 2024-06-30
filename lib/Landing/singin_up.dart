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

class SingInUp extends StatefulWidget {
  String phone_number;
  String isNotApprove;
  String token_user;

  SingInUp(this.phone_number, this.isNotApprove, this.token_user, {super.key});

  @override
  State<SingInUp> createState() => _SingInUpState();
}

class _SingInUpState extends State<SingInUp> {
  bool _isLoading = false;

  String gender = "";
  List<String> items = ['Erbil', 'Sulaymaniyah', 'Duhok', 'Halabja'];
  String city = "Erbil";
  bool nameE = false;
  bool ageE = false;
  bool cityE = false;
  bool genderE = false;
  String token2 = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController age = TextEditingController();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    gettokenDevices();
    super.initState();
  }

  Future<void> gettokenDevices() async {
    if (Platform.isAndroid) {
      String check = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      if (check.toLowerCase() == "HUAWEI".toLowerCase()) {
        Push.enableLogger();
        Push.disableLogger();
        initPlatformState();
        Push.getToken('');
      } else {
        FirebaseMessaging.instance
            .getToken(
                // vapidKey: firebaseCloudvapidKey
                )
            .then((val) async {
          token2 = val.toString();
        });
      }
    } else {
      FirebaseMessaging.instance
          .getToken(
              // vapidKey: firebaseCloudvapidKey
              )
          .then((val) async {
        token2 = val.toString();
      });
    }
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    await Push.setAutoInitEnabled(true);

    Push.getTokenStream.listen(
      _onTokenEvent,
      onError: _onTokenError,
    );
  }

  void _onTokenEvent(String event) {
    token2 = event;
  }

  void _onTokenError(Object error) {
    PlatformException e = error as PlatformException;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColorWhite,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorGrey,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(getHeight(context, 3)),
              width: getWidth(context, 100),
              child: Column(
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      "Complete Account".tr,
                      style: TextStyle(
                          color: mainColorBlack,
                          fontSize: 30,
                          fontFamily: mainFontbold),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 1),
                  ),
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                        "Enter your account information to complete your account"
                            .tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontnormal,
                        )),
                  ),
                  SizedBox(
                    height: getHeight(context, 4),
                  ),
                  FadeInDown(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: TextFormField(
                      controller: nameController,
                      cursorColor: mainColorGrey,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          nameE = false;
                        });
                      },
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorGrey, // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: mainColorGrey
                                .withOpacity(0.5), // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        labelText: "Name".tr,
                        labelStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.8),
                            fontSize: 18,
                            fontFamily: mainFontbold),
                        hintText: "Enter your Name".tr,
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                      ),
                    ),
                  ),
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
                                "Enter your full name".tr,
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
                    height: getHeight(context, 3),
                  ),
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
                                        0.5), // Customize border color
                                    width: 1.0, // Customize border width
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "City".tr,
                                labelStyle: TextStyle(
                                    color: mainColorBlack,
                                    fontSize: 18,
                                    fontFamily: mainFontbold),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mainColorBlack.withOpacity(
                                          0.5), // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                    borderRadius: BorderRadius.circular(15.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: city,
                                isDense: true,
                                onChanged: true
                                    ? null
                                    : (value) {
                                        setState(() {
                                          city = value.toString();
                                        });
                                      },
                                items: items.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value.tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: mainFontnormal),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: getHeight(context, 3),
                  ),
                  FadeInDown(
                    delay: const Duration(milliseconds: 700),
                    duration: const Duration(milliseconds: 500),
                    child: TextFormField(
                      controller: age,
                      cursorColor: mainColorGrey,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          ageE = false;
                        });
                      },
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: mainColorGrey, // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: mainColorGrey
                                .withOpacity(0.5), // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        labelText: "Age".tr,
                        labelStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.8),
                            fontSize: 18,
                            fontFamily: mainFontbold),
                        hintText: "Enter your age".tr,
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                      ),
                    ),
                  ),
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
                                "please, Enter the number only".tr,
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
                    height: getHeight(context, 2),
                  ),
                  FadeInDown(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 500),
                    child: _genderWidget(true, false),
                  ),
                  SizedBox(
                    height: getHeight(context, 15),
                  ),
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

  _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.manufacturer;
  }

  _readIosDeviceInfo(IosDeviceInfo data) {
    return data.name;
  }

  bool containsOnlyNumbers(String text) {
    final RegExp numberRegex = RegExp(r'^[0-9]+$');
    return numberRegex.hasMatch(text);
  }

  Widget _genderWidget(bool showOther, bool alignment) {
    return Container(
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        verticalAlignedText: alignment,
        onChanged: (value) {
          final split = value.toString().split('.');
          gender = split[1];
        },
        selectedGenderTextStyle: TextStyle(
          fontFamily: mainFontnormal,
        ),
        unSelectedGenderTextStyle: TextStyle(
          fontFamily: mainFontnormal,
        ),
        maleText: "Male".tr,
        femaleText: "Female".tr,
        selectedGender: gender == "Male"
            ? Gender.Male
            : gender == ""
                ? null
                : Gender.Female, //By Default
        equallyAligned: true,
        size: 70.0, // default size 40.0
        animationDuration: const Duration(seconds: 1),
        isCircular: true, // by default true
        opacityOfGradient: 0.5,
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
