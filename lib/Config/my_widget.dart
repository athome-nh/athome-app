import 'package:athome/Config/property.dart';
import 'package:athome/landing/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

SnackBar noInternetSnackBar = SnackBar(
  duration: const Duration(seconds: 4),
  content: const Text(
    'You\'re offline, connect to a network.',
  ),
  backgroundColor: mainColorGrey,
);
SnackBar internetBackSnackBar = const SnackBar(
  duration: Duration(seconds: 3),
  content: Text(
    'You\'re online ✅',
  ),
  backgroundColor: Colors.green,
);

Future toastShort(
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColorRed.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 14.0);
}

Future toastLong(
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColorRed.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 14.0);
}

// success Alert
Future<void> successAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    type: QuickAlertType.success,
    title: title,
    text: content,
  );
}

// error Alert
Future<void> errorAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    type: QuickAlertType.error,
    title: title,
    text: content,
  );
}

// warning Alert
Future<void> warningAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    type: QuickAlertType.warning,
    title: title,
    text: content,
  );
}

// info Alert
Future<void> infoAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    headerBackgroundColor: mainColorGrey,
    type: QuickAlertType.info,
    title: title,
    text: content,
  );
}

// confirm Alert
Future<void> confirmAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    type: QuickAlertType.confirm,
    title: title,
    text: content,
    confirmBtnText: 'Yes',
    cancelBtnText: 'No',
  );
}

// loading
Future<void> loadingAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.loading,
    title: title,
    text: content,
  );
}

Future<void> alert(BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: mainColorGrey,
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          width: getWidth(context, 80),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: mainColorGrey,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: getHeight(context, 6),
                decoration: BoxDecoration(
                    color: mainColorRed,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'defaultf',
                        color: mainColorGrey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: getHeight(context, 3), bottom: 0),
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: 'defaultf',
                    color: mainColorWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  height: getHeight(context, 5),
                  width: getWidth(context, 25),
                  margin: EdgeInsets.only(
                      top: getHeight(context, 3),
                      bottom: getHeight(context, 1)),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: mainColorRed,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          fontFamily: 'defaultf',
                          color: mainColorWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ))
            ],
          ),
        ),
      );
    },
  );
}

Future<void> yesNoOptrins(
    BuildContext context, String title, String message, double line) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: mainColorRed,
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          width: getWidth(context, 80),
          height: getHeight(context, 21 + line),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: mainColorGrey,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Stack(
            children: [
              Container(
                height: getHeight(context, 6),
                decoration: BoxDecoration(
                    color: mainColorRed,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'defaultf',
                        color: mainColorWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.only(top: getHeight(context, 6), bottom: 0),
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: 'defaultf',
                    color: mainColorWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: (getHeight(context, 21 + line)) -
                          getHeight(context, 6),
                    ),
                    child: Container(
                        height: getHeight(context, 5),
                        width: getWidth(context, 18),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: mainColorRed,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            // Get.back();
                          },
                          child: Text(
                            "Cancle",
                            style: TextStyle(
                                fontFamily: 'defaultf',
                                color: mainColorRed,
                                fontSize: getWidth(context, 4),
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: getWidth(context, 5),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: (getHeight(context, 21 + line)) -
                          getHeight(context, 6),
                    ),
                    child: Container(
                        height: getHeight(context, 5),
                        width: getWidth(context, 18),
                        decoration: BoxDecoration(
                            color: mainColorRed,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "ok",
                            style: TextStyle(
                                fontFamily: 'defaultf',
                                color: mainColorGrey,
                                fontSize: getWidth(context, 4),
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

loginFirstContainer(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: EdgeInsets.only(
            //   left: getWidth(context,5),
            //   right: getWidth(context,5),
            //   top: getHeight(context,21),
            //   bottom: getHeight(context,21),
            // ),
            width: getWidth(context, 90),
            height: getWidth(context, 100),
            decoration: BoxDecoration(
              border: Border.all(
                color: mainColorRed,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
              color: mainColorGrey,
            ),
            child: Column(
              children: [
                Container(
                  width: getWidth(context, 90),
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: mainColorRed,
                  ),
                  child: Center(
                    child: Text(
                      "Warning",
                      style: TextStyle(
                        fontFamily: "RK",
                        color: mainColorWhite,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(context, 2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: getWidth(context, 4)),
                      width: getWidth(context, 30),
                      height: getWidth(context, 30),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: mainColorWhite,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        color: mainColorGrey,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: mainColorWhite,
                        size: getWidth(context, 27),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(context, 4)),
                Text(
                  "You need to login first",
                  style: TextStyle(
                      fontFamily: 'defaultf',
                      color: mainColorWhite,
                      fontSize: 25,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: getHeight(context, 4)),
                Container(
                  margin: EdgeInsets.only(
                    top: getHeight(context, 2),
                  ),
                  height: 45,
                  width: getWidth(context, 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: mainColorRed,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterWithPhoneNumber()),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontFamily: 'defaultf',
                        fontSize: 18,
                        color: mainColorWhite,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

loginFirstModal(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // margin: EdgeInsets.only(
                  //   left: getWidth(context,5),
                  //   right: getWidth(context,5),
                  //   top: getHeight(context,21),
                  //   bottom: getHeight(context,21),
                  // ),
                  width: getWidth(context, 90),
                  height: getWidth(context, 100),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: mainColorGrey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: mainColorGrey,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: getWidth(context, 90),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: mainColorRed,
                        ),
                        child: Center(
                          child: Text(
                            "Warning",
                            style: TextStyle(
                              fontFamily: "RK",
                              color: mainColorWhite,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: getHeight(context, 2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(bottom: getWidth(context, 4)),
                            width: getWidth(context, 30),
                            height: getWidth(context, 30),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: mainColorWhite,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(100),
                              color: mainColorGrey,
                            ),
                            child: Icon(
                              Icons.person_outline,
                              color: mainColorWhite,
                              size: getWidth(context, 27),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(context, 4)),
                      Text(
                        "You need to login first",
                        style: TextStyle(
                            fontFamily: 'defaultf',
                            color: mainColorRed,
                            fontSize: 25,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: getHeight(context, 4)),
                      Container(
                        margin: EdgeInsets.only(
                          top: getHeight(context, 2),
                        ),
                        height: 45,
                        width: getWidth(context, 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: mainColorRed,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterWithPhoneNumber()),
                            );
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              fontFamily: 'defaultf',
                              fontSize: 18,
                              color: mainColorWhite,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
