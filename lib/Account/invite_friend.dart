import 'package:dllylas/Network/Network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Config/property.dart';

import '../Landing/splash_screen.dart';
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
                        mystate(() {});
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
                      foregroundColor:
                          _controllercoderefer.text != userdata["code"]
                              ? mainColorWhite
                              : mainColorBlack,
                      backgroundColor:
                          _controllercoderefer.text != userdata["code"]
                              ? mainColorGrey
                              : Colors.grey[300],
                      fixedSize: Size(
                        getWidth(context, 90),
                        getHeight(context, 6),
                      ),
                    ),
                    onPressed: _controllercoderefer.text == userdata["code"]
                        ? null
                        : () {
                            var data = {
                              "id": userdata["id"],
                              "code": _controllercoderefer.text.trim()
                            };
                            Network(false)
                                .postData("referUser", data, context)
                                .then((value) {
                              print(value);
                              if (value != "") {
                                if (value["code"] == "200") {
                                  if (value["code"] == "full") {
                                    print("after 3 ");
                                  }
                                  if (value["code"] == "used") {
                                    print("after this persion apply");
                                  } else {
                                    _controllercoderefer.clear();
                                    mystate(() {
                                      userdata["refer"] = value["data"];
                                    });
                                    Navigator.pop(context);
                                  }
                                } else {}
                              } else {}
                            });
                          },
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
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/refer.png",
                    ),
                    SizedBox(height: getHeight(context, 2)),
                    Text(
                      "Invite your friends",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: mainFontbold,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: getHeight(context, 1)),
                    Text(
                      textAlign: TextAlign.center,
                      "Just share this code with your friends and ask them to signup and add this code. Both of you will get ahead of the waitlist",
                      style: TextStyle(fontSize: 16, fontFamily: mainFontbold),
                    ),
                    SizedBox(height: getHeight(context, 2)),

                    TextFormField(
                      controller: _controllercode,
                      readOnly: true,
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

                    SizedBox(height: getHeight(context, 2)),

                    // Invite Botton
                    Row(
                      mainAxisAlignment: userdata["refer"] == null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: Size(
                              getWidth(
                                  context, userdata["refer"] == null ? 45 : 90),
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
                                      getWidth(context, 45),
                                      getHeight(context, 6),
                                    ),
                                    backgroundColor: mainColorRed),
                                onPressed: () => _showBottomSheet(context),
                                child: Text(
                                  "Enter Refer Code".tr,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
