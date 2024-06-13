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
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            ),
            child: SingleChildScrollView(
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
                      onChanged: (value) {
                        mystate(() {
                          
                        });
                      },
                      controller: _controllercoderefer,
                      decoration: InputDecoration(
                   
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: mainColorGrey,
                            width: 1.0,
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
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(context, 3)),
                  TextButton(
                    style: TextButton.styleFrom(
                         foregroundColor: _controllercoderefer.text != userdata["code"]
                                                                            ? mainColorWhite
                                                                            : mainColorBlack,
                                                                        backgroundColor: _controllercoderefer.text != userdata["code"]
                                                                            ? mainColorGrey
                                                                            : Colors.grey[300],
                      fixedSize: Size(
                        getWidth(context, 90),
                        getHeight(context, 6),
                      ),
                    ),
                    onPressed: _controllercoderefer.text == userdata["code"]
                        ? null
                        : () {},
                    child: Text(
                      "Apply".tr,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
                    TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size(
                          getWidth(context, 90),
                          getHeight(context, 6),
                        ),
                      ),
                      onPressed: () async {
                        final result = await Share.share(
                            'Download the app https://dllylas.com\n\n Code: ' +
                                _controllercode.text);
                        if (result.status == ShareResultStatus.success) {
                          print('Thank you for sharing my website!');
                        }
                      },
                      child: Text(
                        "Invite friends now".tr,
                      ),
                    ),

                    userdata["refer"] == null
                        ? SizedBox(height: getHeight(context, 1))
                        : SizedBox(),

                    // Refer Botton
                    userdata["refer"] == null
                        ? TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: Size(
                                getWidth(context, 90),
                                getHeight(context, 6),
                              ),
                            ),
                            onPressed: () => _showBottomSheet(context),
                            child: Text(
                              "Enter Refer Code".tr,
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
