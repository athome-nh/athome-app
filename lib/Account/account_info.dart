import 'package:dllylas/Config/local_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelection extends StatefulWidget {
  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String selectedItem = 'English';
  String lang = 'en';

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language".tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Row(
                  children: [
                    Image.asset(
                      "assets/images/uk.png",
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(width: 10),
                    Text("English".tr),
                  ],
                ),
                value: 'English',
                groupValue: selectedItem,
                onChanged: (value) {
                  setState(() {
                    selectedItem = value!;
                    lang = 'en';
                    Get.updateLocale(Locale("en"));
                    setStringPrefs("lang", "en");
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Row(
                  children: [
                    Image.asset(
                      "assets/images/iraq.png",
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(width: 10),
                    Text("Arabic".tr),
                  ],
                ),
                value: 'Arabic',
                groupValue: selectedItem,
                onChanged: (value) {
                  setState(() {
                    selectedItem = value!;
                    lang = 'ar';
                    Get.updateLocale(Locale("ar"));
                    setStringPrefs("lang", "ar");
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Row(
                  children: [
                    Image.asset(
                      "assets/images/flag.png",
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(width: 10),
                    Text("Kurdish".tr),
                  ],
                ),
                value: 'Kurdish',
                groupValue: selectedItem,
                onChanged: (value) {
                  setState(() {
                    selectedItem = value!;
                    lang = 'kur';
                    Get.updateLocale(Locale("kur"));
                    setStringPrefs("lang", "kur");
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel".tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: _showLanguageDialog,
          child: Text(
            selectedItem == 'English'
                ? "English".tr
                : selectedItem == 'Arabic'
                    ? "Arabic".tr
                    : "Kurdish".tr,
          ),
        ),
      ],
    );
  }
}

