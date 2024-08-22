// Import necessary packages and libraries
import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Landing/verification.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/Privacy.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

/// A StatefulWidget that provides a registration screen for users to enter their phone number.
///
/// This screen handles the input of a phone number, validates it, and provides feedback
/// to the user. It also includes a loading state to manage network requests and interactions
/// with the registration process.
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isLoading = false;
  int max = 11;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,

        // AppBar
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

        // Body
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(context, 4)),
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Image or Gif
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

                        // Text
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

                        // Text
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

                        // space
                        SizedBox(
                          height: getHeight(context, 4),
                        ),

                        // Container of Phone Number
                        FadeInDown(
                          delay: const Duration(milliseconds: 400),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                              color: mainColorWhite,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: mainColorGrey.withOpacity(0.5)),
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
                                        return 'Please enter your phone number'
                                            .tr;
                                      }
                                      if (userInput.length < max) {
                                        return 'Please enter your phone number correct'
                                            .tr;
                                      }

                                      if (userInput.length == max) {}
                                      return null;
                                    },
                                    maxLength: max,
                                    keyboardType: TextInputType.number,
                                    cursorColor: mainColorRed,
                                    inputDecoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 15, left: 0),
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

                        // space
                        SizedBox(
                          height: getHeight(context, 1),
                        ),

                        // Text
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrivacyScreen()));
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

                        // space
                        SizedBox(
                          height: getHeight(context, 8),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Button
                        FadeInDown(
                          delay: const Duration(milliseconds: 600),
                          child: TextButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    if (await noInternet(context)) {
                                      return;
                                    }
                                    if (controller.text.isEmpty) {
                                      toastLong(
                                          'Please enter your phone number'.tr);
                                      return;
                                    }

                                    if (controller.text.length < max) {
                                      toastLong(
                                          'Please enter your phone number'.tr);
                                      return;
                                    }
                                    String ph = controller.text.trim();
                                    if (controller.text.startsWith("0")) {
                                      ph = ph.substring(1);
                                    }
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    ph = "+964$ph";
                                    RQsms(ph);
                                  },
                            style: TextButton.styleFrom(
                                fixedSize: Size(getWidth(context, 100),
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
                                    "Get Start".tr,
                                    style: TextStyle(
                                      color: mainColorWhite,
                                      fontFamily: mainFontbold,
                                    ),
                                  ),
                          ),
                        ),

                        // space
                        SizedBox(
                          height: getHeight(context, 2),
                        ),

                        // Text
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Sends an SMS request to the server with the provided phone number.
  ///
  /// This function handles the process of sending a phone number to the server for SMS
  /// verification. It processes the server's response and shows appropriate dialogs based on
  /// the response status. If an SMS is successfully sent, it navigates to the verification screen.
  ///
  /// [phone_number] The phone number to be used for sending the SMS.
  void RQsms(String phone_number) {
    // Prepare the data to be sent in the request
    var data = {
      "phone": phone_number,
    };

    // Send the SMS request to the server
    Network(false).postData("dllylaslogo", data, context).then((value) async {
      // Reset loading state once response is received
      setState(() {
        _isLoading = false;
      });

      // Check if the response value is not empty
      if (value != "") {
        // Handle different response cases
        if (value["code"] == "200") {
          // Check if the account is pending approval
          if (value["isNotApprove"] == "true") {
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
                            // Display pending account image
                            Image.asset(
                              "assets/Victors/pendding.png",
                              width: getWidth(context, 40),
                              height: getWidth(context, 40),
                            ),
                            SizedBox(height: 10),
                            // Display account pending text
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
                            // OK button to close the dialog
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                      // Close button for the dialog
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

          // Check if the account is disabled
          if (value["isNotActive"] == "true") {
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
                            // Display disabled account image
                            Image.asset(
                              "assets/Victors/disabled.png",
                              width: getWidth(context, 40),
                              height: getWidth(context, 40),
                            ),
                            SizedBox(height: 10),
                            // Display account disabled text
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
                            // OK button to close the dialog
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                      // Close button for the dialog
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

          // Check if the SMS was sent successfully
          if (value["isSendSms"] == "true") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Verificatoin(
                          phone_number,
                        )));
          } else {
            toastShort("unknown occurred error please try again later".tr);
            setState(() {
              _isLoading = false;
            });
          }
        } else {
          // Handle other error codes
          setState(() {
            _isLoading = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Directionality(
                  textDirection:
                      lang == "en" ? TextDirection.ltr : TextDirection.rtl,
                  child: Stack(
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
                            // Display pending account image for error
                            Image.asset(
                              "assets/Victors/pendding.png",
                              width: getWidth(context, 40),
                              height: getWidth(context, 40),
                            ),
                            const SizedBox(height: 10),
                            // Display error text
                            Text(
                              "Account range out".tr,
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
                              "Account range out content".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontnormal,
                                fontSize: 16,
                              ),
                            ),
                            // OK button to close the dialog
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
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
                      // Close button for the dialog
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
        }
      } else {
        // Handle the case where no response is received
        toastShort("unknown occurred error please try again later".tr);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}