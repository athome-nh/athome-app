import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Switchscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String selectedLanguage = 'English';
  List<String> items = [
    'Male',
    'Female',
  ];
  String gender = "Male";
  String selectedItem = 'English';
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: mainColorWhite,
          appBar: AppBar(
            //  elevation: 0,
            backgroundColor: mainColorWhite,
            title: Text(
              'My App',
              style: TextStyle(
                  color: mainColorGrey, fontFamily: mainFontbold, fontSize: 25),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: DropdownButton<String>(
                  underline: Container(),
                  value: selectedItem,
                  icon: Icon(
                    Icons.language,
                    size: 24,
                    color: mainColorGrey,
                  ),
                  iconSize: 32,
                  iconEnabledColor: Colors.red,
                  style: TextStyle(
                    color: mainColorGrey,
                    fontSize: 18, // Text size
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue!;
                      if (newValue == 'English') {
                        lang = "en";
                        Get.updateLocale(Locale("en"));
                        setStringPrefs("lang", "en");
                      } else if (newValue == 'Arabic') {
                        lang = "ar";
                        Get.updateLocale(Locale("ar"));
                        setStringPrefs("lang", "ar");
                      } else {
                        lang = "kur";
                        Get.updateLocale(Locale("kur"));
                        setStringPrefs("lang", "kur");
                      }
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'English',
                      child: Text(
                        'EN ',
                        style: TextStyle(fontFamily: mainFontnormal),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Arabic',
                      child: Text(
                        'AR',
                        style: TextStyle(fontFamily: mainFontnormal),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Kurdish',
                      child: Text(
                        'KU',
                        style: TextStyle(fontFamily: mainFontnormal),
                      ),
                    ),
                  ],
                ),
              ),

              // IconButton(
              //   icon: Icon(
              //     Icons.language,
              //     color: mainColorWhite,
              //   ),
              //   onPressed: () {},
              // ),
            ],
          ),
          body: !isLogin
              ? loginFirstContainer(context)
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundColor:
                                  mainColorRed, // Set a background color
                              child: const Icon(
                                Icons.person,
                                size: 50.0,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jeger Hunar Iphony",
                                    style: TextStyle(
                                        fontFamily: mainFontbold,
                                        fontSize: 18,
                                        color: mainColorGrey),
                                  ),
                                  SizedBox(
                                    height: getHeight(context, 1),
                                  ),
                                  Text(
                                    "+964 7xx xxx xxxx",
                                    style: TextStyle(
                                        fontFamily: mainFontbold,
                                        fontSize: 18,
                                        color: mainColorGrey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      isEdit
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEdit = false;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 10),
                                    child: Container(
                                      width: getWidth(context, 16),
                                      height: getHeight(context, 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: mainColorRed),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.check,
                                            size: 15.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Save",
                                            style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 12,
                                                color: mainColorWhite),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEdit = false;
                                    });
                                  },
                                  child: Container(
                                    width: getWidth(context, 16),
                                    height: getHeight(context, 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColorRed),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.close,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Cancle",
                                          style: TextStyle(
                                              fontFamily: mainFontbold,
                                              fontSize: 12,
                                              color: mainColorWhite),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEdit = true;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 10),
                                    child: Container(
                                      width: getWidth(context, 15),
                                      height: getHeight(context, 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: mainColorRed),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.edit,
                                            size: 20.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            " Edit",
                                            style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 12,
                                                color: mainColorWhite),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: getWidth(context, 55),
                                  height: getHeight(context, 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: mainColorRed),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.disabled_by_default_outlined,
                                        size: 20.0,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " I want to Delete my account",
                                        style: TextStyle(
                                            fontFamily: mainFontbold,
                                            fontSize: 12,
                                            color: mainColorWhite),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: getHeight(context, 2),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 3.5),
                        ),
                        child: Container(
                          width: getWidth(context, 93),
                          height: getHeight(context, 24),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: mainColorGrey),
                          child: Column(
                            children: [
                              SizedBox(
                                height: getHeight(context, 1),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: mainColorWhite,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    enabled: isEdit,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: mainColorWhite,
                                          width: 2.0,
                                        ),
                                      ),
                                      suffixIconColor: mainColorWhite,
                                      hintText: 'Enter Name',
                                      hintStyle: TextStyle(
                                          color: mainColorWhite,
                                          fontFamily: mainFontnormal),
                                      suffixIcon: Icon(
                                        isEdit ? Icons.edit : Icons.person,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: mainColorWhite,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    enabled: isEdit,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: mainColorWhite,
                                          width: 2.0,
                                        ),
                                      ),
                                      suffixIconColor: mainColorWhite,
                                      hintText: 'Enter Age',
                                      hintStyle:
                                          TextStyle(color: mainColorWhite),
                                      suffixIcon: Icon(
                                        isEdit
                                            ? Icons.edit
                                            : Icons.calendar_month,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 15),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       border: Border(
                              //         bottom: BorderSide(
                              //           width: 2,
                              //           color: mainColorWhite,
                              //         ),
                              //       ),
                              //     ),
                              //     child: TextField(
                              //       decoration: InputDecoration(
                              //         border: UnderlineInputBorder(
                              //           borderSide: BorderSide(
                              //             color: mainColorWhite,
                              //             width: 2.0,
                              //           ),
                              //         ),
                              //         suffixIconColor: mainColorWhite,
                              //         hintText: 'Enter City',
                              //         hintStyle: TextStyle(color: mainColorWhite),
                              //         suffixIcon: const Icon(
                              //           Icons.location_city,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: mainColorWhite,
                                      ),
                                    ),
                                  ),
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: mainColorWhite,
                                              width: 2.0,
                                            ),
                                          ),
                                          suffixIconColor: mainColorWhite,
                                          hintStyle:
                                              TextStyle(color: mainColorWhite),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            style: TextStyle(
                                                color: mainColorBlack),
                                            value: gender,
                                            isDense: true,
                                            dropdownColor: mainColorGrey,
                                            onChanged: (value) {
                                              setState(() {
                                                gender = value.toString();
                                              });
                                            },
                                            items: items.map((String value) {
                                              return DropdownMenuItem<String>(
                                                enabled: isEdit,
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          mainFontnormal,
                                                      color: mainColorWhite),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: getWidth(context, 93),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: mainColorGrey),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Loyalty point",
                                  style: TextStyle(
                                      fontFamily: mainFontbold,
                                      fontSize: 16,
                                      color: mainColorWhite),
                                ),
                                const Icon(
                                  Icons.logout,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: getWidth(context, 93),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: mainColorGrey),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      fontFamily: mainFontbold,
                                      fontSize: 16,
                                      color: mainColorWhite),
                                ),
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: getWidth(context, 93),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: mainColorGrey),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "About us",
                                  style: TextStyle(
                                      fontFamily: mainFontbold,
                                      fontSize: 16,
                                      color: mainColorWhite),
                                ),
                                const Icon(
                                  Icons.info_outlined,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: getWidth(context, 93),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: mainColorGrey),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Signout",
                                  style: TextStyle(
                                      fontFamily: mainFontbold,
                                      fontSize: 16,
                                      color: mainColorWhite),
                                ),
                                const Icon(
                                  Icons.logout,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
