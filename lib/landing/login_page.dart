// ignore: depend_on_referenced_packages
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/landing/verification.dart';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterWithPhoneNumber extends StatefulWidget {
  const RegisterWithPhoneNumber({Key? key}) : super(key: key);

  @override
  _RegisterWithPhoneNumberState createState() =>
      _RegisterWithPhoneNumberState();
}

class _RegisterWithPhoneNumberState extends State<RegisterWithPhoneNumber> {
  final TextEditingController controller = TextEditingController();

  int _currentIndex = 0;
  PhoneNumber initialPhoneNumber = PhoneNumber(
    isoCode: 'IQ', // Set the default country code here
  );
  @override
  void initState() {
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
    // TODO: implement dispose
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
            width: getWidth(context, 100),
            height: getHeight(context, 88),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
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
                  height: getHeight(context, 6),
                ),
                FadeInDown(
                  child: Text(
                    'Wellcome back',
                    style: TextStyle(
                        fontFamily: spedaBold,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: mainColorGrey),
                  ),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20),
                    child: Text(
                      'Enter your phone number to Shop Smarter & Easier.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, color: mainColorGrey.withOpacity(0.7)),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 4),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 400),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: mainColorWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: mainColorGrey.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffeeeeee),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        InternationalPhoneNumberInput(
                          countries: ["IQ"],
                          initialValue: initialPhoneNumber,
                          onInputChanged: (PhoneNumber number) {},
                          onInputValidated: (bool value) {},
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle: TextStyle(color: mainColorGrey),
                          textFieldController: controller,
                          formatInput: false,
                          validator: (userInput) {
                            if (userInput!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (userInput.length < 10) {
                              return 'Please enter your phone number correct';
                            }
                            if (userInput.toString().startsWith("0")) {
                              return 'Please remove 0 form start';
                            }
                            return null; // Return null when the input is valid
                          },
                          maxLength: 10,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          cursorColor: mainColorRed,
                          inputDecoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            hintStyle:
                                TextStyle(color: mainColorGrey, fontSize: 16),
                          ),
                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
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
                  height: getHeight(context, 14),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 600),
                  child: MaterialButton(
                    minWidth: getWidth(context, 100),
                    onPressed: () {
                      if (controller.text.isEmpty) {
                        toastLong('Please enter your phone number');
                        return;
                      }
                      if (controller.text.startsWith("0")) {
                        toastLong('Please remove 0 form start');
                        return;
                      }
                      if (controller.text.length < 10) {
                        toastLong('Please enter your phone number');
                        return;
                      }
                      String ph = controller.text.trim();
                      ph = "+964" + ph;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Verificatoin(ph)));
                    },
                    color: mainColorRed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text(
                      "Request OTP",
                      style: TextStyle(color: mainColorWhite),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 800),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "We will send you OTP code to verifiy your phone number.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, color: mainColorGrey.withOpacity(0.7)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
