import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/Switchscreen.dart';
import 'package:athome/home/NavSwitch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:gender_picker/source/enums.dart';

class Singinup_page extends StatefulWidget {
  String phone_number;
  String uid;
  Singinup_page(this.phone_number, this.uid, {super.key});

  @override
  State<Singinup_page> createState() => _Singinup_pageState();
}

class _Singinup_pageState extends State<Singinup_page> {
  bool _isLoading = false;

  String age = '18';
  String gender = "";
  List<String> items = [
    'Select City',
    'Erbil',
    'Sulaymaniyah',
    'Duhok',
    'Halabja'
  ];
  String city = "Select City";
  bool nameE = false;
  bool ageE = false;
  bool cityE = false;
  bool genderE = false;
  String token = "";
  TextEditingController nameController = TextEditingController();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  List<String> agelist = ["18", "19", "20", "21", "22", "23"];
  @override
  void initState() {
    FirebaseMessaging.instance
        .getToken(
            // vapidKey: firebaseCloudvapidKey
            )
        .then((val) async {
      token = val.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: mainColorRed,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(getHeight(context, 3)),
            width: getWidth(context, 100),
            child: Column(
              children: [
                FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "Complete Account",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 30,
                        fontFamily: spedaBold),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "Enter your account information to complete your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: mainColorGrey, fontFamily: Speda),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 4),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 500),
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: mainColorGrey,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        nameE = false;
                      });
                    },
                    validator: (value) {},
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
                      labelText: "Name",
                      labelStyle: TextStyle(
                          color: mainColorGrey.withOpacity(0.8),
                          fontSize: 18,
                          fontFamily: spedaBold),
                      hintText: "Enter your Name",

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
                              "Enter your full name",
                              style: TextStyle(
                                fontFamily: 'defaultf',
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
                    delay: Duration(milliseconds: 600),
                    duration: Duration(milliseconds: 500),
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
                              labelText: "City",
                              labelStyle: TextStyle(
                                  color: mainColorGrey,
                                  fontSize: 18,
                                  fontFamily: spedaBold),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: mainColorGrey.withOpacity(
                                        0.5), // Customize border color
                                    width: 1.0, // Customize border width
                                  ),
                                  borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: city,
                              isDense: true,
                              onChanged: (value) {
                                setState(() {
                                  city = value.toString();
                                });
                              },
                              items: items.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  enabled: value == "Erbil" ? true : false,
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
                    delay: Duration(milliseconds: 700),
                    duration: Duration(milliseconds: 500),
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
                              labelText: "Age",
                              labelStyle: TextStyle(
                                  color: mainColorGrey,
                                  fontSize: 18,
                                  fontFamily: spedaBold),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: mainColorGrey.withOpacity(
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
                                  child: Text(value),
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
                  delay: Duration(milliseconds: 800),
                  duration: Duration(milliseconds: 500),
                  child: _genderWidget(true, false),
                ),
                SizedBox(
                  height: getHeight(context, 15),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 900),
                  duration: Duration(milliseconds: 500),
                  child: MaterialButton(
                    minWidth: getWidth(context, 100),
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
                        "img": "img",
                        "fcmToken": token,
                        "device": Platform.isAndroid
                            ? _readAndroidBuildData(
                                    await deviceInfoPlugin.androidInfo)
                                .toString()
                            : _readIosDeviceInfo(
                                await deviceInfoPlugin.iosInfo),
                        "platform": Platform.isAndroid ? "android" : "ios",
                        "password": widget.uid,
                      };
                      Network(false)
                          .postData("register", data, context)
                          .then((value) {
                        if (value != "") {
                          if (value["code"] == "201") {
                            if (value["data"]["isActive"] == 1) {
                              Save_data_josn('user', value["data"])
                                  .then((save) {
                                if (save) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  setBoolPrefs("islogin", true);
                                  setStringPrefs("token", value["token"]);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Switchscreen()),
                                  );
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  //data not saved
                                  toastShort(
                                      "unknown occurred error please try again later");
                                }
                              });
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              //account is diactive
                            }
                          }
                        } else {
                          toastShort(
                              "unknown occurred error please try again later");
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      });
                    },
                    color: mainColorRed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: _isLoading
                        ? Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              backgroundColor: mainColorWhite,
                              color: mainColorGrey,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Confirm",
                            style: TextStyle(color: mainColorWhite),
                          ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.device;
  }

  _readIosDeviceInfo(IosDeviceInfo data) {
    return data.model;
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

  Widget _genderWidget(bool _showOther, bool _alignment) {
    return Container(
      //margin: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        verticalAlignedText: _alignment,
        onChanged: (value) {
          final split = value.toString().split('.');
          print(split[1]);
          gender = split[1];
        },

        selectedGender: gender == "Male"
            ? Gender.Male
            : gender == ""
                ? null
                : Gender.Female, //By Default
        selectedGenderTextStyle:
            TextStyle(color: mainColorRed, fontFamily: spedaBold, fontSize: 20),
        unSelectedGenderTextStyle: TextStyle(
            color: mainColorGrey, fontFamily: spedaBold, fontSize: 20),
        equallyAligned: true,
        size: 70.0, // default size 40.0
        animationDuration: Duration(seconds: 1),
        isCircular: true, // by default true
        opacityOfGradient: 0.5,
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}
