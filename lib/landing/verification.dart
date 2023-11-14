import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Landing/splash_screen.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/landing/login_page.dart';
import 'package:athome/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../home/nav_switch.dart';
import 'singin_up.dart';

class Verificatoin extends StatefulWidget {
  String phone_number;
  Verificatoin(this.phone_number, {Key? key}) : super(key: key);

  @override
  _VerificatoinState createState() => _VerificatoinState();
}

class _VerificatoinState extends State<Verificatoin> {
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  String _code = '';
  int timecode = 60;
  late Timer _codeTimer;
  String token2 = "";
  int _currentIndex = 0;

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
                              color: mainColorGrey,
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
                            color: Colors.grey.shade500,
                            fontFamily: mainFontbold,
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
                      child: VerificationCode(
                        length: 6,
                        textStyle:
                            TextStyle(fontSize: 20, color: mainColorGrey),
                        underlineColor: mainColorRed,
                        keyboardType: TextInputType.number,
                        underlineUnfocusedColor: mainColorGrey,
                        onCompleted: (value) async {
                          _code = value;
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (await noInternet(context)) {
                            return;
                          }
                          verifySmsCode();
                        },
                        onEditing: (value) {},
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
                          Text(
                            "Don't resive the OTP ?".tr,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade500),
                          ),
                          TextButton(
                              onPressed: () {
                                if (timecode == 0) {
                                  _codeTimer.cancel();
                                  verfyphone();
                                } else {
                                  toastShort(
                                      "Hold till the waiting time ends".tr);
                                }
                              },
                              child: Text(
                                timecode != 0
                                    ? "Try again in".tr +
                                        formatedTime(timeInSecond: timecode)
                                    : "Resend".tr,
                                style: TextStyle(
                                    color: mainColorRed,
                                    fontFamily: mainFontnormal,
                                    fontSize: 12),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 6),
                    ),
                    FadeInDown(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 500),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Customize the border radius
                        ),
                        elevation: 0,
                        onPressed: _code.length < 6
                            ? () => {toastLong("Please enter code".tr)}
                            : () async {
                                if (await noInternet(context)) {
                                  return;
                                }
                                verifySmsCode();
                              },
                        color: mainColorRed,
                        minWidth: getWidth(context, 100),
                        height: getHeight(context, 5.5),
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
                                style: TextStyle(
                                    color: mainColorWhite,
                                    fontSize: 14,
                                    fontFamily: mainFontbold),
                              ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  Future<void> verfyphone() async {
    timecode = 60;

    _codeTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (timecode < 1) {
          _codeTimer.cancel();
        } else {
          timecode--;
        }
      });
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone_number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          _isLoading = true;
        });

        try {
          await _auth.signInWithCredential(credential);
          var data = {
            "token": token2,
            "phone": widget.phone_number,
            "password": _auth.currentUser!.uid.toString(),
          };
          Network(false).postData("login", data, context).then((value) async {
            if (value != "") {
              if (value["code"] == "200") {
                if (value["isActive"] == 1) {
                  _codeTimer.cancel();
                  setState(() {
                    _isLoading = false;
                    _isVerified = true;
                    isLogin = true;
                    loaddata = false;
                    token = value["token"];
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Stack(
                          alignment: lang == "en"
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          children: [
                            Container(
                              width: getWidth(context, 70),
                              height: getHeight(context, 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/003_welcome_1.png",
                                    width: getWidth(context, 40),
                                    height: getWidth(context, 40),
                                  ),
                                  SizedBox(
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
                                  SizedBox(height: 10),
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
                                            builder: (context) =>
                                                const RegisterWithPhoneNumber()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(getWidth(context, 70),
                                          getHeight(context, 5)),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: mainColorGrey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      "OK".tr,
                                      style: TextStyle(
                                        color: mainColorGrey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                      );
                    },
                  );
                }
              } else if (value["code"] == "422") {
                setState(() {
                  _isLoading = false;
                  _isVerified = true;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingInUp(
                            widget.phone_number, _auth.currentUser!.uid)));
              }
            } else {
              toastShort("unknown occurred error please try again later".tr);
              setState(() {
                _isLoading = false;
              });
            }
          });
        } catch (e) {
          toastLong("the code is un correct".tr);

          setState(() {
            _isLoading = false;
            _isVerified = false;
          });
        }
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifySmsCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _code,
    );

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithCredential(credential);
      var data = {
        "token": token2,
        "phone": widget.phone_number,
        "password": _auth.currentUser!.uid.toString(),
      };
      Network(false).postData("login", data, context).then((value) async {
        if (value != "") {
          if (value["code"] == "200") {
            if (value["isApprove"] == 0) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      alignment:
                          lang == "en" ? Alignment.topLeft : Alignment.topRight,
                      children: [
                        Container(
                          width: getWidth(context, 70),
                          height: getHeight(context, 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/003_welcome_1.png",
                                width: getWidth(context, 40),
                                height: getWidth(context, 40),
                              ),
                              SizedBox(
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
                              SizedBox(height: 10),
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
                                        builder: (context) =>
                                            const RegisterWithPhoneNumber()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(getWidth(context, 70),
                                      getHeight(context, 5)),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: mainColorGrey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  "OK".tr,
                                  style: TextStyle(
                                    color: mainColorGrey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close))
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
                _isVerified = true;
                isLogin = true;
                loaddata = false;
                token = value["token"];
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      alignment:
                          lang == "en" ? Alignment.topLeft : Alignment.topRight,
                      children: [
                        Container(
                          width: getWidth(context, 70),
                          height: getHeight(context, 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/003_welcome_1.png",
                                width: getWidth(context, 40),
                                height: getWidth(context, 40),
                              ),
                              SizedBox(
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
                              SizedBox(height: 10),
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
                                        builder: (context) =>
                                            const RegisterWithPhoneNumber()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(getWidth(context, 70),
                                      getHeight(context, 5)),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: mainColorGrey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  "OK".tr,
                                  style: TextStyle(
                                    color: mainColorGrey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close))
                      ],
                    ),
                  );
                },
              );
            }
          } else if (value["code"] == "422") {
            setState(() {
              _isLoading = false;
              _isVerified = true;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SingInUp(widget.phone_number, _auth.currentUser!.uid)));
          }
        } else {
          // toastShort("unknown occurred error please try again later");
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      toastLong("the code is un correct".tr);
      setState(() {
        _isLoading = false;
        _isVerified = false;
      });
    }
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
