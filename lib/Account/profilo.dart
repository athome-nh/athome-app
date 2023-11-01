import 'dart:convert';
import 'dart:io';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/landing/splash_screen.dart';
import 'package:athome/map/loction.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Config/athome_functions.dart';
import '../controller/cartprovider.dart';
import '../main.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final picker = ImagePicker();
  XFile? _image;

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  String selectedLanguage = 'English';
  // Todo: (Jegr) Male and Female translate for other language not worked.
  List<String> items = [
    'Male',
    'Female',
  ];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String gender = "Male";

  String selectedItem = 'English';
  bool isEdit = false;
  bool waiting = false;
  String image = "";
  @override
  void initState() {
    selectedItem = lang == "en"
        ? 'English'
        : lang == "ar"
            ? 'Arabic'
            : 'Kurdish';
    if (isLogin) {
      nameController.text = userdata["name"];
      ageController.text = userdata["age"].toString();
      gender = userdata["gender"];
      image = userdata["img"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          backgroundColor: mainColorWhite,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Image.asset(
            "assets/images/logoB.png",
            width: getWidth(context, 30),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                underline: Container(),
                value: selectedItem,
                icon: SizedBox(),
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
                      Get.updateLocale(const Locale("en"));
                      setStringPrefs("lang", "en");
                    } else if (newValue == 'Arabic') {
                      lang = "ar";
                      Get.updateLocale(const Locale("ar"));
                      setStringPrefs("lang", "ar");
                    } else {
                      lang = "kur";
                      Get.updateLocale(const Locale("kur"));
                      setStringPrefs("lang", "kur");
                    }
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'English',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/flag_english.png"),
                        Container(
                          padding: EdgeInsets.only(
                            top: getWidth(context, 2),
                            left: getWidth(context, 2),
                            right: getWidth(context, 2),
                            bottom: getWidth(context, 1),
                          ),
                          child: Text(
                            'English'.tr,
                            style: TextStyle(fontFamily: mainFontnormal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Arabic',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/flag_iraq.png"),
                        Container(
                          padding: EdgeInsets.only(
                            top: getWidth(context, 2),
                            left: getWidth(context, 2),
                            right: getWidth(context, 2),
                            bottom: getWidth(context, 1),
                          ),
                          child: Text(
                            'Arabic'.tr,
                            style: TextStyle(fontFamily: mainFontnormal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Kurdish',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/flag_kurdish.png"),
                        Container(
                          padding: EdgeInsets.only(
                            top: getWidth(context, 2),
                            left: getWidth(context, 2),
                            right: getWidth(context, 2),
                            bottom: getWidth(context, 1),
                          ),
                          child: Text(
                            'Kurdish'.tr,
                            style: TextStyle(fontFamily: mainFontnormal),
                          ),
                        ),
                      ],
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: getWidth(context, 3.5),
                            right: getWidth(context, 3.5),
                            top: getWidth(context, 3.5),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // image
                                GestureDetector(
                                  onTap: isEdit
                                      ? () {
                                          _getImage();
                                        }
                                      : null,
                                  child: _image != null
                                      ? Container(
                                          width: getWidth(context, 20),
                                          height: getWidth(context, 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.file(
                                              File(_image!.path),
                                              height: 200,
                                              width: 200,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: getWidth(context, 20),
                                          height: getWidth(context, 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: CachedNetworkImage(
                                              width: getWidth(context, 18),
                                              imageUrl: image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                ),

                                // name and phone
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // user name
                                      Text(
                                        userdata["name"],
                                        style: TextStyle(
                                            fontFamily: mainFontbold,
                                            fontSize: 18,
                                            color: mainColorGrey),
                                      ),
                                      SizedBox(
                                        height: getHeight(context, 1),
                                      ),
                                      // phone
                                      Text(
                                        userdata["phone"],
                                        style: TextStyle(
                                            fontFamily: mainFontbold,
                                            fontSize: 16,
                                            color: mainColorGrey),
                                      ),
                                    ],
                                  ),
                                ),

                                // edit button
                                isEdit
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: waiting
                                                ? null
                                                : () async {
                                                    setState(() {
                                                      waiting = true;
                                                    });

                                                    var data = {};

                                                    if (_image == null) {
                                                      data = {
                                                        "id": userdata["id"],
                                                        "name":
                                                            nameController.text,
                                                        "age":
                                                            ageController.text,
                                                        "gender": gender,
                                                      };
                                                      Network(false)
                                                          .postData("profile",
                                                              data, context)
                                                          .then((value) {
                                                        if (value != "") {
                                                          if (value["code"] ==
                                                              "201") {
                                                            userdata =
                                                                value["data"];
                                                            var jsonData = json
                                                                .encode(value[
                                                                    "data"]);
                                                            setStringPrefs(
                                                                "userData",
                                                                encryptAES(
                                                                        jsonData)
                                                                    .toString());
                                                            setState(() {
                                                              waiting = false;
                                                              isEdit = false;
                                                            });
                                                          }
                                                        }
                                                      });
                                                    } else {
                                                      Map<String, String> body =
                                                          {
                                                        "id": userdata["id"]
                                                            .toString(),
                                                      };

                                                      Network(false)
                                                          .addImage(body,
                                                              _image!.path)
                                                          .then((value) {
                                                        if (value) {
                                                          data = {
                                                            "id":
                                                                userdata["id"],
                                                            "name":
                                                                nameController
                                                                    .text,
                                                            "age": ageController
                                                                .text,
                                                            "gender": gender,
                                                          };
                                                          Network(false)
                                                              .postData(
                                                                  "profile",
                                                                  data,
                                                                  context)
                                                              .then((value2) {
                                                            if (value2 != "") {
                                                              if (value2[
                                                                      "code"] ==
                                                                  "201") {
                                                                userdata =
                                                                    value2[
                                                                        "data"];
                                                                var jsonData =
                                                                    json.encode(
                                                                        value2[
                                                                            "data"]);
                                                                setStringPrefs(
                                                                    "userData",
                                                                    jsonData
                                                                        .toString());
                                                                setState(() {
                                                                  userdata[
                                                                      "img"] = value2[
                                                                          "data"]
                                                                      ["img"];
                                                                  waiting =
                                                                      false;
                                                                  isEdit =
                                                                      false;
                                                                });
                                                              }
                                                            }
                                                          });
                                                        }
                                                      });
                                                    }
                                                  },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: getWidth(context, 2),
                                                left: getWidth(context, 2),
                                                right: getWidth(context, 2),
                                                bottom: getWidth(context, 1),
                                              ),
                                              width: getWidth(context, 16),
                                              height: getWidth(context, 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mainColorRed),
                                              child: Center(
                                                child: Text(
                                                  "Save".tr,
                                                  style: TextStyle(
                                                      fontFamily: mainFontbold,
                                                      fontSize: 14,
                                                      color: mainColorWhite),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: getWidth(context, 2),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _image = null;
                                                image = userdata["img"];
                                                isEdit = false;
                                                nameController.text =
                                                    userdata["name"];
                                                ageController.text =
                                                    userdata["age"].toString();
                                                gender = userdata["gender"];
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: getWidth(context, 2),
                                                left: getWidth(context, 2),
                                                right: getWidth(context, 2),
                                                bottom: getWidth(context, 1),
                                              ),
                                              width: getWidth(context, 16),
                                              height: getWidth(context, 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mainColorRed),
                                              child: Center(
                                                child: Text(
                                                  "Cancel".tr,
                                                  style: TextStyle(
                                                      fontFamily: mainFontbold,
                                                      fontSize: 14,
                                                      color: mainColorWhite),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isEdit = true;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                top: getWidth(context, 2),
                                                left: getWidth(context, 2),
                                                right: getWidth(context, 2),
                                                bottom: getWidth(context, 1),
                                              ),
                                              width: getWidth(context, 16),
                                              height: getWidth(context, 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: mainColorRed,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Edit".tr,
                                                  style: TextStyle(
                                                      fontFamily: mainFontbold,
                                                      fontSize: 14,
                                                      color: mainColorWhite),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
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
                            height: getHeight(context, 24),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: mainColorSuger.withOpacity(0.7),
                                ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: getHeight(context, 1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                        //prefixText: "Name: ",

                                        suffixIconColor: mainColorGrey,
                                        hintText: 'Enter Name'.tr,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                        //prefixText: "Age: ",
                                        hintText: 'Enter Age'.tr,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                            //prefixText: "Gender: ",
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
                                              icon: const SizedBox(),
                                              style: TextStyle(
                                                  color: mainColorBlack),
                                              value: gender,
                                              isDense: true,
                                              dropdownColor: mainColorWhite,
                                              onChanged: !isEdit
                                                  ? null
                                                  : (value) {
                                                      setState(() {
                                                        gender =
                                                            value.toString();
                                                      });
                                                    },
                                              isExpanded: true,
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
                        // SizedBox(
                        //   height: getHeight(context, 1),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: getWidth(context, 3.5),
                        //   ),
                        //   child: Container(
                        //     width: getWidth(context, 93),
                        //     height: getHeight(context, 5),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(5),
                        //         color: mainColorLightGrey),
                        //     child: Padding(
                        //       padding:
                        //           const EdgeInsets.symmetric(horizontal: 15),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Text(
                        //             "Loyalty point".tr,
                        //             style: TextStyle(
                        //                 fontFamily: mainFontbold,
                        //                 fontSize: 18,
                        //                 color: mainColorGrey),
                        //           ),
                        //           Icon(
                        //             Icons.loyalty,
                        //             size: getWidth(context, 8),
                        //             color: mainColorGrey,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LocationScreen()),
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
                                  color: mainColorSuger.withOpacity(0.7),
                                  ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                color: mainColorSuger.withOpacity(0.7),
                                ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            getStringPrefs("data").then((map) {
                              Map<String, dynamic> myMap = json.decode(map);
                              myMap["islogin"] = false;
                              myMap["token"] = "";
                              setStringPrefs("data", json.encode(myMap));
                            });

                            final cartProvider = Provider.of<CartProvider>(
                                context,
                                listen: false);

                            setState(() {
                              userdata = {};
                              token = "";
                              isLogin = false;
                            });
                            cartProvider.cartItems.clear();
                            cartProvider.FavItems.clear();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SplashScreen()),
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
                                  color: mainColorSuger.withOpacity(0.7),
                                  ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                    waiting ? WaitingWiget(context) : const SizedBox(),
                  ],
                ),
              ),
      ),
    );
  }
}
