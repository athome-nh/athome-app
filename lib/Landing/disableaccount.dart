import 'package:flutter/material.dart';
import 'package:get/get.dart';

class disableaccount extends StatefulWidget {
  const disableaccount({super.key});

  @override
  State<disableaccount> createState() => _disableaccountState();
}

class _disableaccountState extends State<disableaccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("account is disabled".tr),
      ),
    );
  }
}
