import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Landing/login_page.dart';
import 'package:dllylas/Landing/splash_screen.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../home/nav_switch.dart';

class SingInUp extends StatefulWidget {
  String phone_number;
  String uid;
  SingInUp(this.phone_number, this.uid, {super.key});

  @override
  State<SingInUp> createState() => _SingInUpState();
}

class _SingInUpState extends State<SingInUp> {
  bool _isLoading = false;

  String age = '18';
  String gender = "";
  List<String> items = ['Erbil', 'Sulaymaniyah', 'Duhok', 'Halabja'];
  String city = "Erbil";
  bool nameE = false;
  bool ageE = false;
  bool cityE = false;
  bool genderE = false;
  String token2 = "";
  TextEditingController nameController = TextEditingController();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  List<String> agelist = [
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50",
    "51",
    "52",
    "53",
    "54",
    "55",
    "56",
    "57",
    "58",
    "59",
    "60",
  ];
  @override
  void initState() {
    FirebaseMessaging.instance
        .getToken(
            // vapidKey: firebaseCloudvapidKey
            )
        .then((val) async {
      token2 = val.toString();
    });
    super.initState();
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
                            color: mainColorBlack, // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorBlack
                                .withOpacity(0.5), // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        labelText: "Name".tr,
                        labelStyle: TextStyle(
                            color: mainColorGrey.withOpacity(0.8),
                            fontSize: 18,
                            fontFamily: mainFontbold),
                        hintText: "Enter your Name".tr,

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
                                  borderRadius: BorderRadius.circular(5),
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
                                    borderRadius: BorderRadius.circular(5.0))),
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
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                labelText: "Age".tr,
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
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: age,
                                isDense: true,
                                onChanged: (value) {
                                  setState(() {
                                    age = value.toString();
                                  });
                                },
                                items: agelist.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
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
                        setState(() {
                          _isLoading = true;
                        });

                        var data = {
                          "phone": widget.phone_number,
                          "name": nameController.text,
                          "city": city == "Select City" ? "Erbil" : city,
                          "age": age.toString(),
                          "gender": gender,
                          "img": gender == "Male"
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
                          "password": widget.uid,
                        };
                        try {
                          Network(false)
                              .postData("register", data, context)
                              .then((value) {
                            if (value != "") {
                              if (value["code"] == "200") {
                                if (value["isApprove"] == 0) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Stack(
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
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: mainColorGrey,
                                                      fontFamily: mainFontbold,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    "Account npt approved by admin yet"
                                                        .tr,
                                                    textAlign: TextAlign.center,
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
                                                                const RegisterWithPhoneNumber()),
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      fixedSize: Size(
                                                          getWidth(context, 70),
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
                                      );
                                    },
                                  );
                                  return;
                                }
                                setState(() {
                                  _isLoading = false;
                                  isLogin = true;
                                  loaddata = false;
                                  token = decryptAES(value["token"]);
                                });
                                getStringPrefs("data").then((map) {
                                  Map<String, dynamic> myMap = json.decode(map);
                                  myMap["islogin"] = true;
                                  myMap["token"] = value["token"];
                                  setStringPrefs("data", json.encode(myMap));
                                });

                                final productrovider =
                                    Provider.of<productProvider>(context,
                                        listen: false);
                                productrovider.updatePost(true);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavSwitch()),
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
    return build.device;
  }

  _readIosDeviceInfo(IosDeviceInfo data) {
    return data.name;
    // 'name': data.name,
    // 'systemName': data.systemName,
    // 'systemVersion': data.systemVersion,
    // 'model': data.model,
    // 'localizedModel': data.localizedModel,
    // 'identifierForVendor': data.identifierForVendor,
    // 'isPhysicalDevice': data.isPhysicalDevice,
    // 'utsname.sysname:': data.utsname.sysname,
    // 'utsname.nodename:': data.utsname.nodename,
    // 'utsname.release:': data.utsname.release,
    // 'utsname.version:': data.utsname.version,
    // 'utsname.machine:': data.utsname.machine,
  }

  Widget _genderWidget(bool showOther, bool alignment) {
    return Container(
      //margin: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        verticalAlignedText: alignment,
        onChanged: (value) {
          print(value);
          final split = value.toString().split('.');
          gender = split[1];
        },
        //textbawar male nd female
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
