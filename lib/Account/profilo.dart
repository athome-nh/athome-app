import 'dart:convert';
import 'dart:io';
import 'package:athome/Account/about_screen.dart';
import 'package:athome/Order/order_screen.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/nav_switch.dart';
import 'package:athome/landing/splash_screen.dart';
import 'package:athome/map/loction.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
      change();
    });
  }

  // change Image
  void change() {
    if (_image != null) {
      setState(() {
        waitingImage = true;
      });
      Map<String, String> body = {
        "id": userdata["id"].toString(),
      };
      Network(false).addImage(body, _image!.path).then((value) {
        setState(() {
          waitingImage = false;
        });
        Provider.of<productProvider>(context, listen: false).updateUser();
      });
      toastLong("Image changed".tr);
    } else {}
  }

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
  bool colapse = false;
  bool waiting = false;
  bool waitingImage = false;
  String image = "";

  @override
  void initState() {
    selectedItem = lang == "en"
        ? "English"
        : lang == "ar"
            ? "Arabic"
            : "Kurdish";
    if (isLogin && userdata.isNotEmpty) {
      nameController.text = userdata["name"];
      ageController.text = userdata["age"].toString();
      gender = userdata["gender"];
      image = userdata["img"];
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<productProvider>(context, listen: true).nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              backgroundColor: mainColorWhite,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  "Account".tr,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<String>(
                      underline: Container(),
                      value: selectedItem,
                      icon: const SizedBox(),
                      dropdownColor: mainColorGrey,
                      style: TextStyle(
                        color: mainColorWhite,
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
                        // English
                        DropdownMenuItem(
                          value: 'English',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/uk.png",
                                width: 35,
                                height: 35,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: getWidth(context, 2),
                                  left: getWidth(context, 2),
                                  right: getWidth(context, 2),
                                  bottom: getWidth(context, 1),
                                ),
                                child: Text(
                                  "English".tr,
                                  style: TextStyle(
                                    fontFamily: mainFontnormal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Arabic
                        DropdownMenuItem(
                          value: "Arabic",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/iraq.png",
                                width: 35,
                                height: 35,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: getWidth(context, 2),
                                  left: getWidth(context, 2),
                                  right: getWidth(context, 2),
                                  bottom: getWidth(context, 1),
                                ),
                                child: Text(
                                  "Arabic".tr,
                                  style: TextStyle(fontFamily: mainFontnormal),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Kurdish
                        DropdownMenuItem(
                          value: 'Kurdish',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/flag.png",
                                width: 35,
                                height: 35,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: getWidth(context, 2),
                                  left: getWidth(context, 2),
                                  right: getWidth(context, 2),
                                  bottom: getWidth(context, 1),
                                ),
                                child: Text(
                                  "Kurdish".tr,
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
              body: !Provider.of<productProvider>(context, listen: true).show
                  ? Skeletonizer(
                      effect: ShimmerEffect.raw(colors: [
                        mainColorGrey.withOpacity(0.1),
                        mainColorWhite,
                        // mainColorRed.withOpacity(0.1),
                      ]),
                      enabled: true,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: getWidth(context, 5),
                                right: getWidth(context, 5),
                                top: getWidth(context, 5),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // image
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          width: getWidth(context, 40),
                                          height: getWidth(context, 40),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              width: getWidth(context, 40),
                                              height: getWidth(context, 40),
                                              imageUrl: imageUrlServer,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      "assets/images/home.png"),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "assets/images/home.png"),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              _getImage();
                                            },
                                            icon: Container(
                                              width: getWidth(context, 12),
                                              height: getWidth(context, 12),
                                              decoration: BoxDecoration(
                                                color: mainColorGrey,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: waitingImage
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: waitingWiget2(
                                                          context),
                                                    )
                                                  : Icon(
                                                      Icons.edit_outlined,
                                                      color: mainColorWhite,
                                                    ),
                                            )),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            userdata["name"].toString(),
                                            style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 26,
                                                color: mainColorBlack),
                                          ),
                                          Text(
                                            userdata["phone"]
                                                .toString()
                                                .substring(4),
                                            style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 16,
                                                color: mainColorBlack),
                                          ),
                                        ],
                                      ),
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
                                horizontal: getWidth(context, 5),
                              ),
                              child: Container(
                                height: colapse
                                    ? getHeight(context, 40)
                                    : getHeight(context, 6),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: mainColorBlack,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (!isEdit) colapse = !colapse;
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: colapse
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.center,
                                          mainAxisAlignment: colapse
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.center,
                                          children: [
                                            colapse
                                                ? SizedBox(
                                                    height:
                                                        getHeight(context, 2),
                                                  )
                                                : SizedBox(),
                                            Row(
                                              children: [
                                                Icon(
                                                  color: mainColorBlack,
                                                  Ionicons.person_outline,
                                                  size: 30,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Information".tr,
                                                  style: TextStyle(
                                                      color: mainColorBlack,
                                                      fontFamily:
                                                          mainFontnormal,
                                                      fontSize: 18),
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  colapse
                                                      ? Icons
                                                          .keyboard_arrow_up_outlined
                                                      : lang == "en"
                                                          ? Icons
                                                              .keyboard_arrow_right_outlined
                                                          : Icons
                                                              .keyboard_arrow_left_outlined,
                                                )
                                              ],
                                            ),

                                            colapse
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        width: getWidth(
                                                            context, 100),
                                                        height: getHeight(
                                                            context, 25),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: mainColorWhite,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: getHeight(
                                                                  context, 1),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    bottom:
                                                                        BorderSide(
                                                                      color:
                                                                          mainColorBlack,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child:
                                                                    TextField(
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainColorBlack,
                                                                      fontFamily:
                                                                          mainFontnormal),
                                                                  enabled:
                                                                      isEdit,
                                                                  controller:
                                                                      nameController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            mainColorBlack,
                                                                      ),
                                                                    ),
                                                                    //prefixText: "Name: ",

                                                                    suffixIconColor:
                                                                        mainColorBlack,
                                                                    hintText:
                                                                        "Enter Name"
                                                                            .tr,
                                                                    hintStyle: TextStyle(
                                                                        color:
                                                                            mainColorBlack,
                                                                        fontFamily:
                                                                            mainFontnormal),
                                                                    suffixIcon:
                                                                        Icon(
                                                                      isEdit
                                                                          ? Icons
                                                                              .edit
                                                                          : Icons
                                                                              .person,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    bottom:
                                                                        BorderSide(
                                                                      color:
                                                                          mainColorBlack,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child:
                                                                    TextField(
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainColorBlack,
                                                                      fontFamily:
                                                                          mainFontnormal),
                                                                  controller:
                                                                      ageController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  enabled:
                                                                      isEdit,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            mainColorBlack,
                                                                      ),
                                                                    ),
                                                                    //prefixText: "Age: ",
                                                                    hintText:
                                                                        "Enter Age"
                                                                            .tr,
                                                                    hintStyle:
                                                                        TextStyle(
                                                                            color:
                                                                                mainColorBlack),
                                                                    suffixIconColor:
                                                                        mainColorBlack,
                                                                    suffixIcon:
                                                                        Icon(
                                                                      isEdit
                                                                          ? Icons
                                                                              .edit
                                                                          : Icons
                                                                              .calendar_month,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    bottom:
                                                                        BorderSide(
                                                                      color:
                                                                          mainColorBlack,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child:
                                                                    FormField<
                                                                        String>(
                                                                  builder: (FormFieldState<
                                                                          String>
                                                                      state) {
                                                                    return InputDecorator(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                mainColorBlack,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                        ),
                                                                        //prefixText: "Gender: ",
                                                                        suffixIconColor:
                                                                            mainColorBlack,
                                                                        suffixIcon:
                                                                            Icon(
                                                                          isEdit
                                                                              ? Icons.edit
                                                                              : gender == "Male"
                                                                                  ? Icons.male
                                                                                  : Icons.female,
                                                                        ),
                                                                        hintStyle:
                                                                            TextStyle(color: mainColorBlack),
                                                                      ),
                                                                      child:
                                                                          DropdownButtonHideUnderline(
                                                                        child: DropdownButton<
                                                                            String>(
                                                                          icon:
                                                                              const SizedBox(),
                                                                          style:
                                                                              TextStyle(color: mainColorBlack),
                                                                          value:
                                                                              gender,
                                                                          isDense:
                                                                              true,
                                                                          dropdownColor:
                                                                              mainColorWhite,
                                                                          onChanged: !isEdit
                                                                              ? null
                                                                              : (value) {
                                                                                  setState(() {
                                                                                    gender = value.toString();
                                                                                  });
                                                                                },
                                                                          isExpanded:
                                                                              true,
                                                                          items:
                                                                              items.map((String value) {
                                                                            return DropdownMenuItem<String>(
                                                                              enabled: isEdit,
                                                                              value: value,
                                                                              child: Text(
                                                                                value,
                                                                                style: TextStyle(color: mainColorBlack, fontFamily: mainFontnormal),
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
                                                      isEdit
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      waiting
                                                                          ? null
                                                                          : () async {
                                                                              setState(() {
                                                                                waiting = true;
                                                                              });

                                                                              var data = {
                                                                                "id": userdata["id"],
                                                                                "name": nameController.text,
                                                                                "age": ageController.text,
                                                                                "gender": gender,
                                                                              };
                                                                              Network(false).postData("profile", data, context).then((value) {
                                                                                if (value != "") {
                                                                                  if (value["code"] == "201") {
                                                                                    userdata = value["data"];

                                                                                    setState(() {
                                                                                      waiting = false;
                                                                                      isEdit = false;
                                                                                    });
                                                                                  }
                                                                                }
                                                                              });
                                                                            },
                                                                  style: TextButton.styleFrom(
                                                                      fixedSize: Size(
                                                                          getWidth(
                                                                              context,
                                                                              40),
                                                                          getHeight(
                                                                              context,
                                                                              5))),
                                                                  child: Text(
                                                                    "Save".tr,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: getWidth(
                                                                      context,
                                                                      2),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      _image =
                                                                          null;
                                                                      image = userdata[
                                                                          "img"];
                                                                      isEdit =
                                                                          false;
                                                                      nameController
                                                                              .text =
                                                                          userdata[
                                                                              "name"];
                                                                      ageController
                                                                          .text = userdata[
                                                                              "age"]
                                                                          .toString();
                                                                      gender =
                                                                          userdata[
                                                                              "gender"];
                                                                    });
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      fixedSize: Size(
                                                                          getWidth(
                                                                              context,
                                                                              39),
                                                                          getHeight(
                                                                              context,
                                                                              5))),
                                                                  child: Text(
                                                                    "Cancel".tr,
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  isEdit = true;
                                                                });
                                                              },
                                                              style: TextButton.styleFrom(
                                                                  fixedSize: Size(
                                                                      getWidth(
                                                                          context,
                                                                          80),
                                                                      getHeight(
                                                                          context,
                                                                          5))),
                                                              child: Text(
                                                                "Edit".tr,
                                                              ),
                                                            )
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            // edit button
                                          ],
                                        ),
                                        waiting
                                            ? waitingWiget(context)
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 2),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 5),
                              ),
                              child: Container(
                                height: getHeight(context, 6),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: mainColorBlack,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrderScreen()),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Ionicons.bag_outline,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Orders".tr,
                                          style: TextStyle(
                                              color: mainColorBlack,
                                              fontFamily: mainFontnormal,
                                              fontSize: 18),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          lang == "en"
                                              ? Icons
                                                  .keyboard_arrow_right_outlined
                                              : Icons
                                                  .keyboard_arrow_left_outlined,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 2),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LocationScreen()),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 5),
                                ),
                                child: Container(
                                  height: getHeight(context, 6),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: mainColorBlack,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LocationScreen()),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            color: mainColorBlack,
                                            Ionicons.location_outline,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Address".tr,
                                            style: TextStyle(
                                                color: mainColorBlack,
                                                fontFamily: mainFontnormal,
                                                fontSize: 18),
                                          ),
                                          const Spacer(),
                                          const Icon(Icons
                                              .keyboard_arrow_right_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 2),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AboutScreen()),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 5),
                                ),
                                child: Container(
                                  height: getHeight(context, 6),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: mainColorBlack,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          color: mainColorBlack,
                                          Ionicons.information_outline,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "About us".tr,
                                          style: TextStyle(
                                              color: mainColorBlack,
                                              fontFamily: mainFontnormal,
                                              fontSize: 18),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                            Icons.keyboard_arrow_right_outlined)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 2),
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
                                final product = Provider.of<productProvider>(
                                    context,
                                    listen: false);

                                setState(() {
                                  userdata = {};
                                  token = "";
                                  isLogin = false;
                                });
                                product.Orderitems.clear();
                                product.location.clear();
                                product.Orders.clear();
                                cartProvider.cartItems.clear();
                                cartProvider.FavItems.clear();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavSwitch()),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 5),
                                ),
                                child: Container(
                                  height: getHeight(context, 6),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: mainColorRed),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.log_out_outline,
                                          color: mainColorRed,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Log out".tr,
                                          style: TextStyle(
                                              color: mainColorRed,
                                              fontFamily: mainFontnormal,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(context, 2),
                            ),
                          ],
                        ),
                      ),
                    )
                  : !isLogin
                      ? loginFirstContainer(context)
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getWidth(context, 5),
                                  right: getWidth(context, 5),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // image
                                      _image != null
                                          ? Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                Container(
                                                  width: getWidth(context, 30),
                                                  height: getWidth(context, 30),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          mainColorGrey,
                                                      backgroundImage:
                                                          FileImage(
                                                        File(_image!.path),
                                                      )),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      _getImage();
                                                    },
                                                    icon: Container(
                                                      width:
                                                          getWidth(context, 8),
                                                      height:
                                                          getWidth(context, 8),
                                                      decoration: BoxDecoration(
                                                        color: mainColorGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      child: waitingImage
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child:
                                                                  waitingWiget2(
                                                                      context),
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 15,
                                                              color:
                                                                  mainColorWhite,
                                                            ),
                                                    )),
                                              ],
                                            )
                                          : Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                Container(
                                                    width:
                                                        getWidth(context, 30),
                                                    height:
                                                        getWidth(context, 30),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          mainColorGrey,
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                        imageUrlServer + image,
                                                      ),
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      _getImage();
                                                    },
                                                    icon: Container(
                                                      width:
                                                          getWidth(context, 8),
                                                      height:
                                                          getWidth(context, 8),
                                                      decoration: BoxDecoration(
                                                        color: mainColorGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: waitingImage
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child:
                                                                  waitingWiget2(
                                                                      context),
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 15,
                                                              color:
                                                                  mainColorWhite,
                                                            ),
                                                    )),
                                              ],
                                            ),

                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              userdata["name"].toString(),
                                              style: TextStyle(
                                                  fontFamily: mainFontbold,
                                                  fontSize: 22,
                                                  color: mainColorBlack),
                                            ),
                                            Chip(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              avatar: Icon(Icons.call),
                                              label: Text(
                                                userdata["phone"]
                                                    .toString()
                                                    .substring(4),
                                                style: TextStyle(
                                                    fontFamily: mainFontbold,
                                                    fontSize: 12,
                                                    color: mainColorBlack),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 5),
                                ),
                                child: Container(
                                  height: colapse
                                      ? getHeight(context, 40)
                                      : getHeight(context, 6),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: mainColorBlack.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (!isEdit) colapse = !colapse;
                                        });
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment: colapse
                                                ? CrossAxisAlignment.start
                                                : CrossAxisAlignment.center,
                                            mainAxisAlignment: colapse
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.center,
                                            children: [
                                              colapse
                                                  ? SizedBox(
                                                      height:
                                                          getHeight(context, 2),
                                                    )
                                                  : SizedBox(),
                                              Row(
                                                children: [
                                                  Icon(
                                                    color: mainColorBlack,
                                                    Ionicons.person_outline,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Information".tr,
                                                    style: TextStyle(
                                                        color: mainColorBlack,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontSize: 16),
                                                  ),
                                                  const Spacer(),
                                                  Icon(
                                                    colapse
                                                        ? Icons
                                                            .keyboard_arrow_up_outlined
                                                        : lang == "en"
                                                            ? Icons
                                                                .keyboard_arrow_right_outlined
                                                            : Icons
                                                                .keyboard_arrow_left_outlined,
                                                  )
                                                ],
                                              ),

                                              colapse
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                          width: getWidth(
                                                              context, 100),
                                                          height: getHeight(
                                                              context, 25),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color:
                                                                mainColorWhite,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height:
                                                                    getHeight(
                                                                        context,
                                                                        1),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color:
                                                                            mainColorBlack,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      TextField(
                                                                    style: TextStyle(
                                                                        color:
                                                                            mainColorBlack,
                                                                        fontFamily:
                                                                            mainFontnormal),
                                                                    enabled:
                                                                        isEdit,
                                                                    controller:
                                                                        nameController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              mainColorBlack,
                                                                        ),
                                                                      ),
                                                                      //prefixText: "Name: ",

                                                                      suffixIconColor:
                                                                          mainColorBlack,
                                                                      hintText:
                                                                          "Enter Name"
                                                                              .tr,
                                                                      hintStyle: TextStyle(
                                                                          color:
                                                                              mainColorBlack,
                                                                          fontFamily:
                                                                              mainFontnormal),
                                                                      suffixIcon:
                                                                          Icon(
                                                                        isEdit
                                                                            ? Icons.edit
                                                                            : Icons.person,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color:
                                                                            mainColorBlack,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      TextField(
                                                                    style: TextStyle(
                                                                        color:
                                                                            mainColorBlack,
                                                                        fontFamily:
                                                                            mainFontnormal),
                                                                    controller:
                                                                        ageController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    enabled:
                                                                        isEdit,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              mainColorBlack,
                                                                        ),
                                                                      ),
                                                                      //prefixText: "Age: ",
                                                                      hintText:
                                                                          "Enter Age"
                                                                              .tr,
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              color: mainColorBlack),
                                                                      suffixIconColor:
                                                                          mainColorBlack,
                                                                      suffixIcon:
                                                                          Icon(
                                                                        isEdit
                                                                            ? Icons.edit
                                                                            : Icons.calendar_month,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      bottom:
                                                                          BorderSide(
                                                                        color:
                                                                            mainColorBlack,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      FormField<
                                                                          String>(
                                                                    builder: (FormFieldState<
                                                                            String>
                                                                        state) {
                                                                      return InputDecorator(
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: mainColorBlack,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          //prefixText: "Gender: ",
                                                                          suffixIconColor:
                                                                              mainColorBlack,
                                                                          suffixIcon:
                                                                              Icon(
                                                                            isEdit
                                                                                ? Icons.edit
                                                                                : gender == "Male"
                                                                                    ? Icons.male
                                                                                    : Icons.female,
                                                                          ),
                                                                          hintStyle:
                                                                              TextStyle(color: mainColorBlack),
                                                                        ),
                                                                        child:
                                                                            DropdownButtonHideUnderline(
                                                                          child:
                                                                              DropdownButton<String>(
                                                                            icon:
                                                                                const SizedBox(),
                                                                            style:
                                                                                TextStyle(color: mainColorBlack),
                                                                            value:
                                                                                gender,
                                                                            isDense:
                                                                                true,
                                                                            dropdownColor:
                                                                                mainColorWhite,
                                                                            onChanged: !isEdit
                                                                                ? null
                                                                                : (value) {
                                                                                    setState(() {
                                                                                      gender = value.toString();
                                                                                    });
                                                                                  },
                                                                            isExpanded:
                                                                                true,
                                                                            items:
                                                                                items.map((String value) {
                                                                              return DropdownMenuItem<String>(
                                                                                enabled: isEdit,
                                                                                value: value,
                                                                                child: Text(
                                                                                  value,
                                                                                  style: TextStyle(color: mainColorBlack),
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
                                                        isEdit
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: waiting
                                                                        ? null
                                                                        : () async {
                                                                            setState(() {
                                                                              waiting = true;
                                                                            });

                                                                            var data =
                                                                                {
                                                                              "id": userdata["id"],
                                                                              "name": nameController.text,
                                                                              "age": ageController.text,
                                                                              "gender": gender,
                                                                            };
                                                                            Network(false).postData("profile", data, context).then((value) {
                                                                              if (value != "") {
                                                                                if (value["code"] == "201") {
                                                                                  userdata = value["data"];

                                                                                  setState(() {
                                                                                    waiting = false;
                                                                                    isEdit = false;
                                                                                  });
                                                                                }
                                                                              }
                                                                            });
                                                                          },
                                                                    style: TextButton.styleFrom(
                                                                        fixedSize: Size(
                                                                            getWidth(context,
                                                                                40),
                                                                            getHeight(context,
                                                                                5))),
                                                                    child: Text(
                                                                      "Save".tr,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: getWidth(
                                                                        context,
                                                                        2),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _image =
                                                                            null;
                                                                        image =
                                                                            userdata["img"];
                                                                        isEdit =
                                                                            false;
                                                                        nameController.text =
                                                                            userdata["name"];
                                                                        ageController
                                                                            .text = userdata[
                                                                                "age"]
                                                                            .toString();
                                                                        gender =
                                                                            userdata["gender"];
                                                                      });
                                                                    },
                                                                    style: TextButton.styleFrom(
                                                                        fixedSize: Size(
                                                                            getWidth(context,
                                                                                39),
                                                                            getHeight(context,
                                                                                5))),
                                                                    child: Text(
                                                                      "Cancel"
                                                                          .tr,
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            : TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    isEdit =
                                                                        true;
                                                                  });
                                                                },
                                                                style: TextButton.styleFrom(
                                                                    fixedSize: Size(
                                                                        getWidth(
                                                                            context,
                                                                            80),
                                                                        getHeight(
                                                                            context,
                                                                            5))),
                                                                child: Text(
                                                                  "Edit".tr,
                                                                ),
                                                              )
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              // edit button
                                            ],
                                          ),
                                          waiting
                                              ? waitingWiget(context)
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 5),
                                ),
                                child: Container(
                                  height: getHeight(context, 6),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: mainColorBlack.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderScreen()),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Ionicons.bag_outline,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Orders".tr,
                                            style: TextStyle(
                                                color: mainColorBlack,
                                                fontFamily: mainFontnormal,
                                                fontSize: 16),
                                          ),
                                          const Spacer(),
                                          Icon(lang == "en"
                                              ? Icons
                                                  .keyboard_arrow_right_outlined
                                              : Icons
                                                  .keyboard_arrow_left_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LocationScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 5),
                                  ),
                                  child: Container(
                                    height: getHeight(context, 6),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              mainColorBlack.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LocationScreen()),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              color: mainColorBlack,
                                              Ionicons.location_outline,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Address".tr,
                                              style: TextStyle(
                                                  color: mainColorBlack,
                                                  fontFamily: mainFontnormal,
                                                  fontSize: 16),
                                            ),
                                            const Spacer(),
                                            Icon(lang == "en"
                                                ? Icons
                                                    .keyboard_arrow_right_outlined
                                                : Icons
                                                    .keyboard_arrow_left_outlined)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AboutScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 5),
                                  ),
                                  child: Container(
                                    height: getHeight(context, 6),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              mainColorBlack.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            color: mainColorBlack,
                                            Ionicons.lock_closed_outline,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Privacy Poilcy".tr,
                                            style: TextStyle(
                                                color: mainColorBlack,
                                                fontFamily: mainFontnormal,
                                                fontSize: 16),
                                          ),
                                          const Spacer(),
                                          Icon(lang == "en"
                                              ? Icons
                                                  .keyboard_arrow_right_outlined
                                              : Icons
                                                  .keyboard_arrow_left_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AboutScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 5),
                                  ),
                                  child: Container(
                                    height: getHeight(context, 6),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              mainColorBlack.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            color: mainColorBlack,
                                            Ionicons.document_text_outline,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Terms Of Use".tr,
                                            style: TextStyle(
                                                color: mainColorBlack,
                                                fontFamily: mainFontnormal,
                                                fontSize: 16),
                                          ),
                                          const Spacer(),
                                          Icon(lang == "en"
                                              ? Icons
                                                  .keyboard_arrow_right_outlined
                                              : Icons
                                                  .keyboard_arrow_left_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AboutScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 5),
                                  ),
                                  child: Container(
                                    height: getHeight(context, 6),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              mainColorBlack.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            color: mainColorBlack,
                                            Ionicons.information_outline,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "About us".tr,
                                            style: TextStyle(
                                                color: mainColorBlack,
                                                fontFamily: mainFontnormal,
                                                fontSize: 16),
                                          ),
                                          const Spacer(),
                                          Icon(lang == "en"
                                              ? Icons
                                                  .keyboard_arrow_right_outlined
                                              : Icons
                                                  .keyboard_arrow_left_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  getStringPrefs("data").then((map) {
                                    Map<String, dynamic> myMap =
                                        json.decode(map);
                                    myMap["islogin"] = false;
                                    myMap["token"] = "";
                                    setStringPrefs("data", json.encode(myMap));
                                  });

                                  final cartProvider =
                                      Provider.of<CartProvider>(context,
                                          listen: false);
                                  final product = Provider.of<productProvider>(
                                      context,
                                      listen: false);

                                  setState(() {
                                    userdata = {};
                                    token = "";
                                    isLogin = false;
                                  });
                                  product.Orderitems.clear();
                                  product.location.clear();
                                  product.Orders.clear();
                                  cartProvider.cartItems.clear();
                                  cartProvider.FavItems.clear();

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NavSwitch()),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 5),
                                  ),
                                  child: Container(
                                    height: getHeight(context, 6),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                mainColorRed.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Ionicons.log_out_outline,
                                            color: mainColorRed,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Log out".tr,
                                            style: TextStyle(
                                                color: mainColorRed,
                                                fontFamily: mainFontnormal,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                            ],
                          ),
                        ),
            ),
          );
  }
}
