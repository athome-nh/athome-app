import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controller/cartprovider.dart';
import '../home/NavSwitch.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String gender = "Male";

  String selectedItem = 'English';
  bool isEdit = false;
  @override
  void initState() {
    selectedItem = lang == "en"
        ? 'English'
        : lang == "ar"
            ? 'Arabic'
            : 'Kurdish';
    if (isLogin) {
      nameController.text = userData["name"];
      ageController.text = userData["age"].toString();
      gender = userData["gender"];
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: mainColorWhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mainColorWhite,
            title: Image.asset(
              "assets/images/logoB.png",
              width: getWidth(context, 30),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: DropdownButton<String>(
                  underline: Container(),
                  value: selectedItem,
                  icon: Icon(
                    Icons.language,
                    size: 25,
                    color: mainColorGrey,
                  ),
                  style: TextStyle(
                    color: mainColorGrey,
                    fontFamily: mainFontbold,
                    fontSize: 16, // Text size
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
                        'English',
                        style: TextStyle(fontFamily: mainFontnormal),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Arabic',
                      child: Text(
                        'Arabic',
                        style: TextStyle(fontFamily: mainFontnormal),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Kurdish',
                      child: Text(
                        'Kurdish',
                        style: TextStyle(fontFamily: mainFontnormal),
                      ),
                    ),
                  ],
                ),
              ),
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
                        padding: EdgeInsets.only(
                          left: getWidth(context, 3.5),
                          right: getWidth(context, 3.5),
                          top: getWidth(context, 3.5),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: mainColorLightGrey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35.0,
                                      backgroundColor:
                                          mainColorLightGrey, // Set a background color
                                      child:
                                          Image.asset("assets/images/408.png"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userData["name"],
                                            style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 18,
                                                color: mainColorGrey),
                                          ),
                                          SizedBox(
                                            height: getHeight(context, 1),
                                          ),
                                          Text(
                                            userData["phone"],
                                            style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 16,
                                                color: mainColorGrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                            child: Container(
                                              width: getWidth(context, 16),
                                              height: getHeight(context, 4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mainColorRed),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            mainFontbold,
                                                        fontSize: 12,
                                                        color: mainColorWhite),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: getWidth(context, 2),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isEdit = false;
                                                nameController.text =
                                                    userData["name"];
                                                ageController.text =
                                                    userData["age"].toString();
                                                gender = userData["gender"];
                                              });
                                            },
                                            child: Container(
                                              width: getWidth(context, 16),
                                              height: getHeight(context, 4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mainColorRed),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            mainFontbold,
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
                                            child: Container(
                                              width: getWidth(context, 30),
                                              height: getHeight(context, 4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mainColorRed),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Edit account",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            mainFontbold,
                                                        fontSize: 12,
                                                        color: mainColorWhite),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: getWidth(context, 2),
                                          ),
                                          Container(
                                            width: getWidth(context, 30),
                                            height: getHeight(context, 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: mainColorRed),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Delete account",
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
                              ],
                            ),
                          ),
                        ),
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
                          height: getHeight(context, 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: mainColorLightGrey),
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
                                        color: mainColorGrey,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontFamily: mainFontnormal),
                                    enabled: isEdit,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: mainColorGrey,
                                          width: 2.0,
                                        ),
                                      ),
                                      prefixText: "Name: ",
                                      suffixIconColor: mainColorGrey,
                                      hintText: 'Enter Name',
                                      hintStyle: TextStyle(
                                          color: mainColorGrey,
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
                                        color: mainColorGrey,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontFamily: mainFontnormal),
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    enabled: isEdit,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: mainColorGrey,
                                          width: 2.0,
                                        ),
                                      ),
                                      prefixText: "Age: ",
                                      hintText: 'Enter Age',
                                      hintStyle:
                                          TextStyle(color: mainColorGrey),
                                      suffixIconColor: mainColorGrey,
                                      suffixIcon: Icon(
                                        isEdit
                                            ? Icons.edit
                                            : Icons.calendar_month,
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
                                        color: mainColorGrey,
                                      ),
                                    ),
                                  ),
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: mainColorGrey,
                                              width: 2.0,
                                            ),
                                          ),
                                          prefixText: "Gender: ",
                                          suffixIconColor: mainColorGrey,
                                          suffixIcon: Icon(
                                            isEdit
                                                ? Icons.edit
                                                : gender == "Male"
                                                    ? Icons.male
                                                    : Icons.female,
                                          ),
                                          hintStyle:
                                              TextStyle(color: mainColorGrey),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            icon: SizedBox(),
                                            style: TextStyle(
                                                color: mainColorBlack),
                                            value: gender,
                                            isDense: true,
                                            dropdownColor: mainColorGrey,
                                            onChanged: !isEdit
                                                ? null
                                                : (value) {
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
                                                      color: mainColorGrey),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 3.5),
                        ),
                        child: Container(
                          width: getWidth(context, 93),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: mainColorLightGrey),
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
                                      fontSize: 18,
                                      color: mainColorGrey),
                                ),
                                Icon(
                                  Icons.loyalty,
                                  size: getWidth(context, 8),
                                  color: mainColorGrey,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 3.5),
                        ),
                        child: Container(
                          width: getWidth(context, 93),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: mainColorLightGrey),
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
                                      fontSize: 18,
                                      color: mainColorGrey),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  size: getWidth(context, 8),
                                  color: mainColorGrey,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 3.5),
                        ),
                        child: Container(
                          width: getWidth(context, 93),
                          height: getHeight(context, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: mainColorLightGrey),
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
                                      fontSize: 18,
                                      color: mainColorGrey),
                                ),
                                Icon(
                                  Icons.info_outlined,
                                  size: getWidth(context, 8),
                                  color: mainColorGrey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      GestureDetector(
                        onTap: () {
                          setBoolPrefs("islogin", false);
                          setStringPrefs("userData", "");
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          userData = {};
                          cartProvider.loadCartFromPreferences();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavSwitch()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 3.5),
                          ),
                          child: Container(
                            width: getWidth(context, 93),
                            height: getHeight(context, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: mainColorLightGrey),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign out",
                                    style: TextStyle(
                                        fontFamily: mainFontbold,
                                        fontSize: 18,
                                        color: mainColorGrey),
                                  ),
                                  Icon(
                                    Icons.logout,
                                    size: getWidth(context, 8),
                                    color: mainColorGrey,
                                  ),
                                ],
                              ),
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
