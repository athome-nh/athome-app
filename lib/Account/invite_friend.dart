import 'package:dllylas/Network/Network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Config/property.dart';

import '../landing/splash_screen.dart';
import '../main.dart';
import 'package:share_plus/share_plus.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  final TextEditingController _controllercode = TextEditingController();
  final TextEditingController _controllercoderefer = TextEditingController();
  void initState() {
    if (userdata["code"] == null) {
      generateInviteCode();
    } else {
      _controllercode.text = userdata["code"];
      setState(() {
        waiting = false;
      });
    }
    super.initState();
  }

  void generateInviteCode() {
    var data = {
      "id": userdata["id"],
    };
    Network(false).postData("createCodeInvite", data, context).then((value) {
      print(value);
      if (value != "") {
        if (value["code"] == "200") {
          _controllercode.text = value["data"];
          userdata["code"] = value["data"];
          setState(() {
            waiting = false;
          });
        } else {}
      } else {}
    });
  }

  bool waiting = true;
  void dispose() {
    _controllercode.dispose();
    super.dispose();
  }

  void _copyText() {
    Clipboard.setData(ClipboardData(text: _controllercode.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Enter your details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: getHeight(context, 3)),
              Container(
                width: getWidth(context, 90),
                height: getWidth(context, 12),
                child: TextFormField(
                  controller: _controllercoderefer,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.copy,
                        color: mainColorGrey,
                      ),
                      onPressed: _copyText,
                    ),
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
                        color: mainColorGrey.withOpacity(0.8),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    labelText: "Referral Code",
                    // hintText: "Copy",
                    hintStyle: TextStyle(
                        color: mainColorBlack.withOpacity(0.5),
                        fontSize: 14,
                        fontFamily: mainFontnormal),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              SizedBox(height: getHeight(context, 3)),
              GestureDetector(
                onTap: _controllercode.text == userdata["code"] ? null : () {},
                child: Container(
                  padding: EdgeInsets.only(
                    top: getWidth(context, 2),
                    left: getWidth(context, 2),
                    right: getWidth(context, 2),
                    bottom: getWidth(context, 1),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: mainColorGrey,
                      border: Border.all(color: mainColorGrey)),
                  width: getWidth(context, 90),
                  height: getWidth(context, 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Apply".tr,
                        style: TextStyle(
                            fontFamily: mainFontbold,
                            fontSize: 14,
                            color: mainColorWhite),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        // AppBar
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
          title: Text(
            "Invite a friend".tr,
          ),
        ),

        body: waiting
            ? Center(
                child: SizedBox(
                height: getWidth(context, 80),
                child: Image.asset("assets/images/LogoLoading.gif"),
                // LoadingIndicator(
                //   indicatorType: Indicator.ballRotateChase,
                //   colors: [
                //     mainColorWhite,
                //     // mainColorRed,
                //     // mainColorSuger,
                //   ],

                //   // strokeWidth: 5,
                // ),
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getHeight(context, 5)),

                    // top image
                    Image.asset(
                      "assets/Victors/login.png",
                      width: getWidth(context, 75),
                    ),

                    // Notification Setting
                    _listTiles(
                        FontAwesomeIcons.one, 'Share your referral code'),
                    _listTiles(FontAwesomeIcons.two,
                        'Friends get \$10 on their first gesture'),
                    _listTiles(
                        FontAwesomeIcons.three, 'You get \$10 off coupon'),
                    SizedBox(height: getHeight(context, 5)),

                    Container(
                      width: getWidth(context, 90),
                      height: getWidth(context, 12),
                      child: TextFormField(
                        controller: _controllercode,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: mainColorGrey,
                            ),
                            onPressed: _copyText,
                          ),
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
                              color: mainColorGrey.withOpacity(0.8),
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          labelText: "Referral Code",
                          // hintText: "Copy",
                          hintStyle: TextStyle(
                              color: mainColorBlack.withOpacity(0.5),
                              fontSize: 14,
                              fontFamily: mainFontnormal),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),

                    SizedBox(height: getHeight(context, 2)),

                    // Invite Botton
                    GestureDetector(
                      onTap: () async {
                        final result = await Share.share(
                            'Dowanload the app https://dllylas.com\n\n Code: ' +
                                _controllercode.text);

                        if (result.status == ShareResultStatus.success) {
                          print('Thank you for sharing my website!');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: getWidth(context, 2),
                          left: getWidth(context, 2),
                          right: getWidth(context, 2),
                          bottom: getWidth(context, 1),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: mainColorGrey,
                            border: Border.all(color: mainColorGrey)),
                        width: getWidth(context, 90),
                        height: getWidth(context, 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              color: mainColorWhite,
                            ),
                            Text(
                              "Invite friends now".tr,
                              style: TextStyle(
                                  fontFamily: mainFontbold,
                                  fontSize: 14,
                                  color: mainColorWhite),
                            ),
                            SizedBox(width: getHeight(context, 5)),
                          ],
                        ),
                      ),
                    ),

                    userdata["refer"] == null
                        ? SizedBox(height: getHeight(context, 1))
                        : SizedBox(),

                    // Invite Botton
                    userdata["refer"] == null
                        ? GestureDetector(
                            onTap: () => _showBottomSheet(context),
                            child: Container(
                              padding: EdgeInsets.only(
                                top: getWidth(context, 2),
                                left: getWidth(context, 2),
                                right: getWidth(context, 2),
                                bottom: getWidth(context, 1),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: mainColorGrey,
                                  border: Border.all(color: mainColorGrey)),
                              width: getWidth(context, 90),
                              height: getWidth(context, 13),
                              child: Center(
                                child: Text(
                                  "Invite friends now".tr,
                                  style: TextStyle(
                                      fontFamily: mainFontbold,
                                      fontSize: 14,
                                      color: mainColorWhite),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _listTiles(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              size: 24,
              color: mainColorGrey,
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: mainFontnormal,
                  color: mainColorGrey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
