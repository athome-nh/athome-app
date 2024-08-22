import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Landing/singin_up.dart';
import '../Landing/splash_screen.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:huawei_push/huawei_push.dart';
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
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String _code = '';
  int timecode = 60;
  late Timer _codeTimer;
  String token2 = "";
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    verfyphone();
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
    // If you want auto init enabled, after getting user agreement call this method.
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
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
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
                      EdgeInsets.symmetric(horizontal: getHeight(context, 2)),
                  height: getHeight(context, 88),
                  width: getWidth(context, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getHeight(context, 20),
                        child: Image.asset(
                          "assets/images/verify.gif",
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 2),
                      ),
                      FadeInDown(
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            "Verification".tr,
                            style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 30,
                                fontFamily: mainFontbold),
                          )),
                      SizedBox(
                        height: getHeight(context, 2),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 400),
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
                        height: getHeight(context, 2),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(milliseconds: 400),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return SizedBox(
                                width: getWidth(context, 10),
                                child: TextField(
                                  autofocus: index == 0 ? true : false,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                  ),
                                  readOnly: true,
                                  controller: _controllers[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.none,
                                  maxLength: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      if (index < _controllers.length - 1) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    } else if (index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 2),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 700),
                        duration: const Duration(milliseconds: 400),
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
                        height: getHeight(context, 2),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Column(
                          children: [
                            FadeInDown(
                              delay: const Duration(milliseconds: 725),
                              duration: const Duration(milliseconds: 400),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildButton('1'),
                                  _buildButton('2'),
                                  _buildButton('3'),
                                ],
                              ),
                            ),
                            FadeInDown(
                              delay: const Duration(milliseconds: 750),
                              duration: const Duration(milliseconds: 400),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildButton('4'),
                                  _buildButton('5'),
                                  _buildButton('6'),
                                ],
                              ),
                            ),
                            FadeInDown(
                              delay: const Duration(milliseconds: 775),
                              duration: const Duration(milliseconds: 400),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildButton('7'),
                                  _buildButton('8'),
                                  _buildButton('9'),
                                ],
                              ),
                            ),
                            FadeInDown(
                              delay: const Duration(milliseconds: 800),
                              duration: const Duration(milliseconds: 400),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildButton('Paste'.tr,
                                      onPressed: _pasteFromClipboard),
                                  _buildButton('0'),
                                  _buildButton_backspace('⌫',
                                      onPressed: _backspace),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 900),
                        duration: const Duration(milliseconds: 400),
                        child: TextButton(
                          onPressed: () async {
                            _code = getVerificationCode();
                            if (_code.length < 6) {
                              toastLong("Please enter code".tr);
                              return;
                            }
                            if (await noInternet(context)) {
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

  String getVerificationCode() {
    // Concatenate the text from all controllers
    return _controllers.map((controller) => controller.text).join('');
  }

  Future<void> _input(String text) async {
    for (var i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.isEmpty) {
        setState(() {
          _controllers[i].text = text;
          if (i < _controllers.length - 1) {
            FocusScope.of(context).nextFocus();
          }
        });
        break;
      }
    }
    _code = getVerificationCode();
    if (_code.length == 6) {
      if (await noInternet(context)) {
        return;
      }

      RQverify();
    }
  }

// 4
  void _backspace() {
    for (var i = _controllers.length - 1; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        setState(() {
          _controllers[i].clear();
          if (i > 0) {
            FocusScope.of(context).previousFocus();
          }
        });
        break;
      }
    }
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

  Future<void> _pasteFromClipboard() async {
    final clipboardData = await Clipboard.getData('text/plain');
    final clipboardText = clipboardData?.text ?? '';

    // Ensure clipboardText length matches the number of fields
    final code = clipboardText
        .trim()
        .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    final codeLength = _controllers.length;

    if (code.length <= codeLength) {
      setState(() {
        for (var i = 0; i < code.length; i++) {
          _controllers[i].text = code[i];
          if (i < codeLength - 1) {
            FocusScope.of(context).nextFocus();
          }
        }
        // Clear remaining fields if code is shorter than the number of fields
        for (var i = code.length; i < codeLength; i++) {
          _controllers[i].clear();
        }
      });
    } else {
    }
    _code = getVerificationCode();
    if (_code.length == 6) {
      if (await noInternet(context)) {
        return;
      }

      RQverify();
    }
  }

  _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.manufacturer;
  }

  Widget _buildButton(String text, {VoidCallback? onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
          fixedSize: Size(getWidth(context, 25), getHeight(context, 3))),
      onPressed: onPressed ?? () => _input(text),
      child: Text(
      text ,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildButton_backspace(String text, {VoidCallback? onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: mainColorRed,
          fixedSize: Size(
            getWidth(context, 25),
            getHeight(context, 3),
          )),
      onPressed: onPressed ?? () => _input(text),
      child: Text(text),
    );
  }

  void RQverify() {
    setState(() {
      _isLoading = true;
    });
    var data = {
      "phone": widget.phone_number,
      "code": _code,
      "token": token2,
    };
    print(_code);
    Network(false).postData("verifyPhone", data, context).then((value) async {
      print(value);
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
                builder: (context) => SingInUp(
                  widget.phone_number,
                  value["isNotApprove"],
                  value["token"],
                ),
              ),
            );
          } else {
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
              MaterialPageRoute(builder: (context) => NavSwitch()),
            );
          }
        }
      } else {
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
