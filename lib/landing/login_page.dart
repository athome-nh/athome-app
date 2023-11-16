import 'package:animate_do/animate_do.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/landing/verification.dart';
import 'package:athome/main.dart';
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
    super.initState();
  }

  @override
  void dispose() {
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
                        color: mainColorGrey),
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
                        color: mainColorGrey,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: mainColorWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: mainColorGrey.withOpacity(0.5)),
                      boxShadow: const [
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
                          countries: const ["IQ"],
                          initialValue: initialPhoneNumber,
                          focusNode: null,
                          onInputChanged: (PhoneNumber number) {},
                          onInputValidated: (bool value) {},
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle: TextStyle(color: mainColorGrey),
                          textFieldController: controller,
                          formatInput: false,
                          validator: (userInput) {
                            if (userInput!.isEmpty) {
                              return 'Please enter your phone number'.tr;
                            }
                            if (userInput.length < 10) {
                              return 'Please enter your phone number correct'
                                  .tr;
                            }
                            if (userInput.toString().startsWith("0")) {
                              return 'Please remove 0 form start'.tr;
                            }
                            if (userInput.length == 10) {}
                            return null; // Return null when the input is valid
                          },
                          maxLength: 10,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          cursorColor: mainColorRed,
                          inputDecoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: 'Phone Number'.tr,
                            hintStyle:
                                TextStyle(color: mainColorGrey, fontSize: 16),
                          ),
                          onSaved: (PhoneNumber number) {},
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
                  delay: const Duration(milliseconds: 600),
                  child: MaterialButton(
                    minWidth: getWidth(context, 100),
                    onPressed: () async {
                      if (await noInternet(context)) {
                        return;
                      }
                      if (controller.text.isEmpty) {
                        toastLong('Please enter your phone number'.tr);
                        return;
                      }
                      if (controller.text.startsWith("0")) {
                        toastLong('Please remove 0 form start'.tr);
                        return;
                      }
                      if (controller.text.length < 10) {
                        toastLong('Please enter your phone number'.tr);
                        return;
                      }

                      String ph = controller.text.trim();
                      ph = "+964$ph";

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Verificatoin(ph)));
                    },
                    color: mainColorRed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
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
                        color: mainColorGrey.withOpacity(0.7),
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
    );
  }
}
