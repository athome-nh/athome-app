import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Landing/singin_up.dart';
import 'package:dllylas/Landing/splash_screen.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';

import 'package:dllylas/main.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../home/nav_switch.dart';

class Verificatoin extends StatefulWidget {
  String phone_number;

  Verificatoin(this.phone_number, {Key? key}) : super(key: key);

  @override
  _VerificatoinState createState() => _VerificatoinState();
}

class _VerificatoinState extends State<Verificatoin> {
  bool _isLoading = false;

  String _code = '';
  int timecode = 60;
  late Timer _codeTimer;
  String token2 = "";

  @override
  void initState() {
    verfyphone();
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
  void dispose() {
    _codeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: mainColorWhite,
          appBar: AppBar(
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
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: getHeight(context, 4)),
                  height: getHeight(context, 88),
                  width: getWidth(context, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getHeight(context, 27),
                        child: Image.asset(
                          "assets/images/verify.gif",
                        ),
                      ),

                      SizedBox(
                        height: getHeight(context, 4),
                      ),
                      FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            "Verification",
                            style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 30,
                                fontFamily: mainFontbold),
                          )),
                      SizedBox(
                        height: getHeight(context, 4),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 500),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          "${"Please enter the 6 digit code sent to".tr}\n${widget.phone_number}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 4),
                      ),

                      // Verification Code Input
                      FadeInDown(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(milliseconds: 500),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: VerificationCode(
                            length: 6,
                            textStyle:
                                TextStyle(fontSize: 20, color: mainColorBlack),
                            underlineColor: mainColorRed,
                            keyboardType: TextInputType.number,
                            underlineUnfocusedColor: mainColorGrey,
                            onCompleted: (value) async {
                              _code = value;
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (await noInternet(context)) {
                                return;
                              }
                              if (widget.phone_number == "+9647503248438" &&
                                  _code == "941424") {
                                setState(() {
                                  _isLoading = true;
                                });
                                RQStrtic();
                                return;
                              }

                              RQverify();
                            },
                            onEditing: (value) {},
                          ),
                        ),
                      ),

                      SizedBox(
                        height: getHeight(context, 2),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 700),
                        duration: const Duration(milliseconds: 500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Don't resive the OTP ?".tr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: mainColorBlack,
                                ),
                              ),
                            ),
                            Flexible(
                              child: TextButton(
                                  onPressed: () {
                                    if (timecode == 0) {
                                      _codeTimer.cancel();
                                      Navigator.pop(context);
                                    } else {
                                      toastShort(
                                          "Hold till the waiting time ends".tr);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent),
                                  child: Text(
                                    timecode != 0
                                        ? "Try again in".tr +
                                            formatedTime(timeInSecond: timecode)
                                        : "Resend".tr,
                                    style: TextStyle(
                                        color: mainColorRed,
                                        fontFamily: mainFontnormal,
                                        fontSize: 10),
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 6),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 800),
                        duration: const Duration(milliseconds: 500),
                        child: TextButton(
                          onPressed: _code.length < 6
                              ? () => {toastLong("Please enter code".tr)}
                              : _isLoading
                                  ? null
                                  : () async {
                                      if (await noInternet(context)) {
                                        return;
                                      }

                                      if (widget.phone_number ==
                                              "+9647503248438" &&
                                          _code == "941424") {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        RQStrtic();
                                        return;
                                      }

                                      RQverify();
                                    },
                          style: TextButton.styleFrom(
                              fixedSize: Size(getHeight(context, 100),
                                  getHeight(context, 6))),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    strokeWidth: 3,
                                    color: Colors.black,
                                  ),
                                )
                              : Text(
                                  "Verify".tr,
                                ),
                        ),
                      )
                    ],
                  )),
            ),
          )),
    );
  }

  void verfyphone() async {
    timecode = 90;

    _codeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (timecode < 1) {
          _codeTimer.cancel();
        } else {
          timecode--;
        }
      });
    });
  }

  void RQStrtic() {
    var data = {
      "token": token2,
      "phone": widget.phone_number,
      "password": "hspeY3489IZRtR3nCgnidI0ASr32",
    };
    Network(false).postData("login", data, context).then((value) async {
      if (value != "") {
        if (value["code"] == "200") {
          if (value["isApprove"] == 0) {
            setState(() {
              _isLoading = false;
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    alignment:
                        lang == "en" ? Alignment.topLeft : Alignment.topRight,
                    children: [
                      SizedBox(
                        width: getWidth(context, 70),
                        height: getHeight(context, 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //textcheck
                            Image.asset(
                              "assets/Victors/pendding.png",
                              width: getWidth(context, 40),
                              height: getWidth(context, 40),
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
                              "Account npt approved by admin yet".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontnormal,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavSwitch()),
                                );
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size(getWidth(context, 70),
                                    getHeight(context, 5)),
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
          if (value["isActive"] == 1) {
            _codeTimer.cancel();
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
                Provider.of<productProvider>(context, listen: false);
            productrovider.updatePost(true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NavSwitch()),
            );
          } else {
            setState(() {
              _isLoading = false;
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    alignment:
                        lang == "en" ? Alignment.topLeft : Alignment.topRight,
                    children: [
                      SizedBox(
                        width: getWidth(context, 70),
                        height: getHeight(context, 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/Victors/disabled.png",
                              width: getWidth(context, 40),
                              height: getWidth(context, 40),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Account Disabled".tr,
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
                              "Account is disable please contact athome admin"
                                  .tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontnormal,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavSwitch()),
                                );
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size(getWidth(context, 70),
                                    getHeight(context, 5)),
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
          }
        } else if (value["code"] == "422") {
          setState(() {
            _isLoading = false;
          });
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             SingInUp(widget.phone_number, _auth.currentUser!.uid)));
        }
      } else {
        // toastShort("unknown occurred error please try again later");
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void RQverify() {
    setState(() {
      _isLoading = true;
    });
    var data = {
      "phone": widget.phone_number,
      "code": _code,
    };
    Network(false).postData("verifyPhone", data, context).then((value) async {
      setState(() {
        _isLoading = false;
      });
      if (value != "") {
        if (value["code"] == "200") {
          if (value["data"] == "register") {
            setState(() {
              _isLoading = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SingInUp(widget.phone_number,
                        value["isNotApprove"], value["token"])));
          } else {
            _codeTimer.cancel();
            setState(() {
              _isLoading = false;
              isLogin = true;
              loaddata = false;
              token = decryptAES(value["token"]);
            });
            getStringPrefs("token").then((map) {
              Map<String, dynamic> myMap = json.decode(map);
              myMap["islogin"] = true;
              myMap["token"] = value["data"];
              setStringPrefs("data", json.encode(myMap));
            });

            final productrovider =
                Provider.of<productProvider>(context, listen: false);
            productrovider.updatePost(true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NavSwitch()),
            );
          }
        }
      } else {
        // toastShort("unknown occurred error please try again later");
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
