import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsandCondition extends StatefulWidget {
  const TermsandCondition({super.key});

  @override
  State<TermsandCondition> createState() => _TermsandConditionState();
}

class _TermsandConditionState extends State<TermsandCondition> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Terms Of Use".tr),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Terms and Condition for Dlly Las Grocery App title".tr,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Terms and Condition for Dlly Las Grocery App content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  "General:".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "General: content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Delivery:".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Delivery: content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Returns and Refunds:".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Returns and Refunds: content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Payment:".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Payment:content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Privacy:".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Privacy:content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Content Protection:".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Content Protection:content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Changes to Terms and Conditions:".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Changes to Terms and Conditions:content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Governing Law:".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Governing Law:content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Contact Us:TC".tr,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Contact Us:TC content".tr,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ));
  }
}
