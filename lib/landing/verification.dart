import 'package:animate_do/animate_do.dart';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/Switchscreen.dart';
import 'package:athome/home/NavSwitch.dart';
import 'package:athome/landing/Singinup_page.dart';
import 'package:athome/landing/complate_account.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_verification_code/flutter_verification_code.dart';

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

  int _currentIndex = 0;

  void initState() {
    verfyphone();
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;

        if (_currentIndex == 3) _currentIndex = 0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    //_codeTimer.cancel();
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
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: getHeight(context, 4)),
              height: getHeight(context, 88),
              width: getWidth(context, 100),
              child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: getHeight(context, 27),
                    child: Stack(children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: AnimatedOpacity(
                          opacity: _currentIndex == 0 ? 1 : 0,
                          duration: Duration(
                            seconds: 1,
                          ),
                          curve: Curves.linear,
                          child: CachedNetworkImage(
                            imageUrl: "assets/images/008_track_1.png",
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: AnimatedOpacity(
                          opacity: _currentIndex == 1 ? 1 : 0,
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          child: CachedNetworkImage(
                            imageUrl: "assets/images/008_track_2.png",
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: AnimatedOpacity(
                          opacity: _currentIndex == 2 ? 1 : 0,
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          child: CachedNetworkImage(
                            imageUrl: "assets/images/008_track_3.png",
                          ),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: getHeight(context, 4),
                  ),
                  FadeInDown(
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        "Verification",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontSize: 30,
                            fontFamily: mainFontMontserrat6),
                      )),
                  SizedBox(
                    height: getHeight(context, 4),
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 500),
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      "Please enter the 6 digit code sent to \n " +
                          widget.phone_number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          height: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 4),
                  ),

                  // Verification Code Input
                  FadeInDown(
                    delay: Duration(milliseconds: 600),
                    duration: Duration(milliseconds: 500),
                    child: VerificationCode(
                      length: 6,
                      textStyle: TextStyle(fontSize: 20, color: mainColorGrey),
                      underlineColor: mainColorRed,
                      keyboardType: TextInputType.number,
                      underlineUnfocusedColor: mainColorGrey,
                      onCompleted: (value) {
                        setState(() {
                          _code = value;
                        });
                      },
                      onEditing: (value) {},
                    ),
                  ),

                  SizedBox(
                    height: getHeight(context, 2),
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 700),
                    duration: Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't resive the OTP?",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade500),
                        ),
                        TextButton(
                            onPressed: () {
                              if (timecode == 0) {
                                _codeTimer.cancel();
                                verfyphone();
                              } else {
                                toastShort("Hold till the waiting time ends");
                              }
                            },
                            child: Text(
                              timecode != 0
                                  ? "Try again in " +
                                      formatedTime(timeInSecond: timecode)
                                          .toString()
                                  : "Resend",
                              style: TextStyle(color: mainColorRed),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 6),
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 800),
                    duration: Duration(milliseconds: 500),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Customize the border radius
                      ),
                      elevation: 0,
                      onPressed: _code.length < 6
                          ? () => {toastLong("Please enter code")}
                          : () {
                              verifySmsCode();
                            },
                      color: mainColorRed,
                      minWidth: getWidth(context, 100),
                      height: getHeight(context, 5.5),
                      child: _isLoading
                          ? Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 3,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              "Verify",
                              style: TextStyle(
                                  color: mainColorWhite, fontSize: 14),
                            ),
                    ),
                  )
                ],
              )),
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
            "phone": widget.phone_number,
            "password": _auth.currentUser!.uid.toString(),
          };
          Network(false).postData("login", data, context).then((value) async {
            if (value != "") {
              if (value["code"] == "200") {
                if (value["data"]["isActive"] == 1) {
                  Save_data_josn('user', value["data"]).then((save) {
                    if (save) {
                      setState(() {
                        _isLoading = false;
                        _isVerified = true;
                      });
                      setBoolPrefs("islogin", true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Switchscreen()),
                      );
                    } else {
                      toastShort(
                          "unknown occurred error please try again later");
                    }
                  });
                } else {
                  alert(context, "Account Disabled",
                      "Account is disable please contact athome admin ");
                }
              } else if (value["code"] == "422") {
                setState(() {
                  _isLoading = false;
                  _isVerified = true;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Singinup_page(
                            widget.phone_number, _auth.currentUser!.uid)));
              }
            } else {
              toastShort("unknown occurred error please try again later");
              setState(() {
                _isLoading = false;
              });
            }
          });
        } catch (e) {
          toastLong("the code is un correct");

          setState(() {
            _isLoading = false;
            _isVerified = false;
          });
          print(e);
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
        "phone": widget.phone_number,
        "password": _auth.currentUser!.uid.toString(),
      };
      Network(false).postData("login", data, context).then((value) async {
        if (value != "") {
          if (value["code"] == "200") {
            if (value["data"]["isActive"] == 1) {
              Save_data_josn('user', value["data"]).then((save) {
                if (save) {
                  setState(() {
                    _isLoading = false;
                    _isVerified = true;
                  });
                  setBoolPrefs("islogin", true);
                  setStringPrefs("token", value["token"]);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Switchscreen()),
                  );
                } else {
                  toastShort("unknown occurred error please try again later");
                  print("data not saved");
                }
              });
            } else {
              alert(context, "Account Disabled",
                  "Account is disable please contact athome admin ");
            }
          } else if (value["code"] == "422") {
            setState(() {
              _isLoading = false;
              _isVerified = true;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Singinup_page(
                        widget.phone_number, _auth.currentUser!.uid)));
          }
        } else {
          toastShort("unknown occurred error please try again later");
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      toastLong("the code is un correct");
      setState(() {
        _isLoading = false;
        _isVerified = false;

        print(e);
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