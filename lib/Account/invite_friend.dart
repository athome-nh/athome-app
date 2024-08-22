// Import necessary packages and libraries
import 'package:dllylas/Network/Network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Config/property.dart';
import '../Landing/splash_screen.dart';
import '../main.dart';
import 'package:share_plus/share_plus.dart';

/// `InvitePage` is a screen where users can invite their friends by sharing a referral code.
/// It allows the user to generate a referral code, copy it to the clipboard, and share it.
class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  final TextEditingController _controllercode = TextEditingController();  // Controller for displaying the referral code
  final TextEditingController _controllercoderefer = TextEditingController();  // Controller for the input referral code

  /// This function is called when the widget is initialized.
  /// It checks if a referral code exists in the user's data. 
  /// If it does not exist, it calls `generateInviteCode` to create one.
  void initState() {
    if (userdata["code"] == null) {
      generateInviteCode();  // Generate a new invite code if it doesn't exist
    } else {
      _controllercode.text = userdata["code"];  // Set the referral code in the text field
      setState(() {
        waiting = false;  // Stop waiting if code exists
      });
    }
    super.initState();  // Call the parent class' initState method
  }

  /// This function sends a request to the server to generate an invite code.
  /// The code is then set in the `_controllercode` and stored in `userdata`.
  void generateInviteCode() {
    var data = {
      "id": userdata["id"],  // User ID to generate invite code
    };
    Network(false).postData("createCodeInvite", data, context).then((value) {
      print(value);
      if (value != "") {
        if (value["code"] == "200") {
          _controllercode.text = value["data"];  // Set the generated invite code
          userdata["code"] = value["data"];  // Store the code in the global `userdata`
          setState(() {
            waiting = false;  // Stop waiting once the code is set
          });
        } else {}
      } else {}
    });
  }

  bool waiting = true;  // Controls the loading state for the page

  /// Disposes the TextEditingController to free up resources when the widget is destroyed.
  void dispose() {
    _controllercode.dispose();  // Dispose of the referral code controller
    super.dispose();  // Call the parent class' dispose method
  }

  /// Copies the current referral code to the clipboard and shows a snackbar confirmation.
  void _copyText() {
    Clipboard.setData(ClipboardData(text: _controllercode.text));  // Copy text to clipboard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard'.tr)),  // Show feedback message
    );
  }

  /// Displays a bottom sheet where the user can enter a referral code to refer a friend.
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,  // Allows the bottom sheet to be resized with the keyboard
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
                    'Enter your details'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  // Title of the bottom sheet
                  ),
                  SizedBox(height: getHeight(context, 3)),
                  
                  // TextFormField for entering referral code
                  Container(
                    width: getWidth(context, 90),
                    height: getWidth(context, 12),
                    child: TextFormField(
                      onChanged: (value) {
                        mystate(() {});  // Updates the state of the bottom sheet on value change
                      },
                      controller: _controllercoderefer,  // Controller for the referral code input
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
                        labelText: "Referral Code".tr,
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(context, 3)),
                  
                  // Button to apply the referral code entered by the user
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
                              "id": userdata["id"],  // User ID for referral
                              "code": _controllercoderefer.text.trim()  // Referral code entered by the user
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
                                    print("after this person apply");
                                  } else {
                                    _controllercoderefer.clear();  // Clear the input field
                                    mystate(() {
                                      userdata["refer"] = value["data"];  // Update user data with referral info
                                    });
                                    Navigator.pop(context);  // Close the bottom sheet
                                  }
                                } else {}
                              } else {}
                            });
                          },
                    child: Text(
                      "Apply".tr,  // Button label for applying the referral code
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
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,  // Handles the text direction based on language
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);  // Navigate back to the previous page
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
          title: Text(
            "Invite a friend".tr,  // Title for the page
          ),
        ),

        // Show loading indicator while waiting for the referral code, otherwise show the invite UI
        body: waiting
            ? Center(
                child: SizedBox(
                height: getWidth(context, 80),
                child: Image.asset("assets/images/LogoLoading.gif"),  // Loading animation
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/refer.png",  // Image showing invitation graphic
                      ),
                      SizedBox(height: getHeight(context, 2)),
                      Text(
                        "Invite your friends".tr,  // Heading text for inviting friends
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: mainFontbold,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: getHeight(context, 1)),
                      Text(
                        textAlign: TextAlign.center,
                        "TextIFP".tr,  // Text explaining the referral process
                        style:
                            TextStyle(fontSize: 16, fontFamily: mainFontbold),
                      ),
                      SizedBox(height: getHeight(context, 2)),

                      // TextFormField to display the user's referral code, with a copy button
                      TextFormField(
                        controller: _controllercode,
                        readOnly: true,  // Referral code is read-only
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: mainColorGrey,
                            ),
                            onPressed: _copyText,  // Copy the referral code to clipboard
                          ),
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
                          labelText: "Referral Code".tr,
                          hintStyle: TextStyle(
                              color: mainColorBlack.withOpacity(0.5),
                              fontSize: 14,
                              fontFamily: mainFontnormal),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),

                      SizedBox(height: getHeight(context, 2)),

                      // Buttons for inviting friends or entering a referral code
                      Row(
                        mainAxisAlignment: userdata["refer"] == null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          // Button to invite friends by sharing the referral code
                          TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: Size(
                                getWidth(context,
                                    userdata["refer"] == null ? 45 : 90),
                                getHeight(context, 6),
                              ),
                            ),
                            onPressed: () async {
                              final result = await Share.share(
                                  "Download the app".tr +
                                      'https://dllylas.com\n\n' +
                                      "Code".tr +
                                      ": " +
                                      _controllercode.text);  // Share the app download link and referral code
                              if (result.status == ShareResultStatus.success) {
                                print('Thank you for sharing my website!');
                              }
                            },
                            child: Text(
                              "Invite friends now".tr,  // Button label for inviting friends
                            ),
                          ),

                          // Button to enter a referral code if the user hasn't been referred yet
                          userdata["refer"] == null
                              ? SizedBox(height: getHeight(context, 1))
                              : SizedBox(),
                              
                          userdata["refer"] == null
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(
                                        getWidth(context, 45),
                                        getHeight(context, 6),
                                      ),
                                      backgroundColor: mainColorGrey),
                                  onPressed: () => _showBottomSheet(context),  // Show the bottom sheet for entering a referral code
                                  child: Text(
                                    "Enter Refer Code".tr,  // Button label for entering a referral code
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
