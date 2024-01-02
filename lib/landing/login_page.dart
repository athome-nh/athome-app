import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Privacy.dart';
import 'package:dllylas/Privacy_Arabic.dart';
import 'package:dllylas/Privacy_Kurdish.dart';
import 'package:dllylas/landing/verification.dart';
import 'package:dllylas/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterWithPhoneNumber extends StatefulWidget {
  const RegisterWithPhoneNumber({Key? key}) : super(key: key);

  @override
  RegisterWithPhoneNumberState createState() => RegisterWithPhoneNumberState();
}

class RegisterWithPhoneNumberState extends State<RegisterWithPhoneNumber> {
  final TextEditingController controller = TextEditingController();

  PhoneNumber initialPhoneNumber = PhoneNumber(
    isoCode: 'IQ',
  );

  @override
  void initState() {
    FirebaseMessaging.instance
        .getAPNSToken(
            // vapidKey: firebaseCloudvapidKey
            )
        .then((val) async {});
    FirebaseMessaging.instance
        .getToken(
            // vapidKey: firebaseCloudvapidKey
            )
        .then((val) async {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int max = 11;
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getHeight(context, 4)),
              child: Column(
                children: [
                  // place of gif image
                  SizedBox(
                    height: getHeight(context, 25),
                    child: Image.asset(
                      "assets/Victors/login.png",
                      width: getWidth(context, 100),
                    ),
                  ),
                  // space
                  SizedBox(
                    height: getHeight(context, 6),
                  ),

                  FadeInDown(
                    child: Text(
                      'Wellcome back'.tr,
                      style: TextStyle(
                          fontFamily: mainFontbold,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: mainColorBlack),
                    ),
                  ),
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20),
                      child: Text(
                        "EnterYourPhoneNumberToShop".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: mainColorBlack,
                          fontFamily: mainFontnormal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 4),
                  ),
                  FadeInDown(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: mainColorWhite,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: mainColorGrey.withOpacity(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: mainColorWhite,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: InternationalPhoneNumberInput(
                              countries: const ["IQ"],
                              initialValue: initialPhoneNumber,
                              focusNode: null,
                              onInputChanged: (PhoneNumber number) {
                                if (controller.text.startsWith("0")) {
                                  setState(() {
                                    max = 11;
                                  });
                                } else {
                                  setState(() {
                                    max = 10;
                                  });
                                }
                              },
                              onInputValidated: (bool value) {},
                              selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              selectorTextStyle:
                                  TextStyle(color: mainColorBlack),
                              textFieldController: controller,
                              formatInput: false,
                              validator: (userInput) {
                                if (userInput!.isEmpty) {
                                  return 'Please enter your phone number'.tr;
                                }
                                if (userInput.length < max) {
                                  return 'Please enter your phone number correct'
                                      .tr;
                                }

                                if (userInput.length == max) {}
                                return null; // Return null when the input is valid
                              },
                              maxLength: max,
                              keyboardType: TextInputType.number,
                              cursorColor: mainColorRed,
                              inputDecoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 15, left: 0),
                                border: InputBorder.none,
                                hintText: 'Phone Number'.tr,
                                hintStyle: TextStyle(
                                    color: mainColorBlack, fontSize: 16),
                              ),
                              onSaved: (PhoneNumber number) {},
                            ),
                          ),
                          Positioned(
                            left: 90,
                            top: 8,
                            bottom: 8,
                            child: Container(
                              height: 40,
                              width: 1,
                              color: mainColorGrey.withOpacity(0.2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 1),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => lang == "en"
                                    ? PrivacyScreen()
                                    : lang == "ar"
                                        ? PrivacyScreen_AR()
                                        : PrivacyScreen_KU()));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: mainColorGrey,
                      ),
                      child: Text(
                        "By continuing, you agree to get Dlly Las's Privacy Policy"
                            .tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      )),
                  SizedBox(
                    height: getHeight(context, 12),
                  ),

                  FadeInDown(
                    delay: const Duration(milliseconds: 600),
                    child: TextButton(
                      onPressed: () async {
                        if (await noInternet(context)) {
                          return;
                        }
                        if (controller.text.isEmpty) {
                          toastLong('Please enter your phone number'.tr);
                          return;
                        }

                        if (controller.text.length < max) {
                          toastLong('Please enter your phone number'.tr);
                          return;
                        }
                        String ph = controller.text.trim();
                        if (controller.text.startsWith("0")) {
                          ph = ph.substring(1);
                        }

                        ph = "+964$ph";

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Verificatoin(ph)));
                      },
                      style: TextButton.styleFrom(
                          fixedSize: Size(
                              getWidth(context, 100), getHeight(context, 6))),
                      child: Text(
                        "Get Start".tr,
                        style: TextStyle(
                          color: mainColorWhite,
                          fontFamily: mainFontbold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 2),
                  ),

                  FadeInDown(
                    delay: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "WeWillSendYouOTP".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: mainColorBlack.withOpacity(0.7),
                          fontFamily: mainFontbold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
