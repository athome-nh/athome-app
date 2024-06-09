import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Account/about_screen.dart';
import 'package:dllylas/Account/chatscreen.dart';
import 'package:dllylas/Account/profilo.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/Order/order_screen.dart';
import 'package:dllylas/Privacy.dart';
import 'package:dllylas/TermsandCondition.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/map/loction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../Config/my_widget.dart';
import 'account_setting.dart';
import 'bawar.dart';
import 'invite_friend.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();
  XFile? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
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
      Network(false).addImage("profileImg", body, _image!.path).then((value) {
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
    "Gender",
    'Male',
    'Female',
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String gender = "Male";

  String selectedItem = 'English';
  bool isEdit = false;
  bool colapse = false;
  bool waiting = false;
  bool waitingImage = false;
  String image = "";
  bool nameE = false;
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
      phoneController.text = userdata["phone"].toString();
      gender = userdata["gender"] ?? "Gender";
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
              // appbar
              appBar: AppBar(
                backgroundColor: mainColorGrey,
                toolbarHeight: 0,
              ),

              // body
              body: !isLogin
                  ? loginFirstContainer(context)
                  : !Provider.of<productProvider>(context, listen: true)
                          .showuser
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  imageUrl: dotenv.env[
                                                          'imageUrlServer']! +
                                                      image,
                                                  filterQuality:
                                                      FilterQuality.low,
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
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: waitingImage
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
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
                                              TextButton(
                                                  onPressed: () {},
                                                  child:
                                                      Text("Delete Account".tr))
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
                                        borderRadius:
                                            BorderRadius.circular(1 - 5)),
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
                                                        height: getHeight(
                                                            context, 2),
                                                      )
                                                    : const SizedBox(),
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
                                                                      .circular(
                                                                          15),
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
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          nameE =
                                                                              false;
                                                                        });
                                                                      },
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
                                                                            "Enter Name".tr,
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
                                                                            "Enter Age".tr,
                                                                        hintStyle:
                                                                            TextStyle(color: mainColorBlack),
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
                                                                    child: FormField<
                                                                        String>(
                                                                      builder: (FormFieldState<
                                                                              String>
                                                                          state) {
                                                                        return InputDecorator(
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                UnderlineInputBorder(
                                                                              borderSide: BorderSide(
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
                                                                              icon: const SizedBox(),
                                                                              style: TextStyle(color: mainColorBlack),
                                                                              value: gender,
                                                                              isDense: true,
                                                                              dropdownColor: mainColorWhite,
                                                                              onChanged: !isEdit
                                                                                  ? null
                                                                                  : (value) {
                                                                                      setState(() {
                                                                                        gender = value.toString();
                                                                                      });
                                                                                    },
                                                                              isExpanded: true,
                                                                              items: items.map((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  enabled: isEdit,
                                                                                  value: value,
                                                                                  child: Text(
                                                                                    value.tr,
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
                                                                      onPressed: waiting
                                                                          ? null
                                                                          : () async {
                                                                              setState(() {
                                                                                waiting = true;
                                                                              });
                                                                              if (nameController.text.isEmpty) {}

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
                                                                              getWidth(context, 40),
                                                                              getHeight(context, 5))),
                                                                      child:
                                                                          Text(
                                                                        "Save"
                                                                            .tr,
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
                                                                          ageController.text =
                                                                              userdata["age"].toString();
                                                                          gender =
                                                                              userdata["gender"];
                                                                        });
                                                                      },
                                                                      style: TextButton.styleFrom(
                                                                          fixedSize: Size(
                                                                              getWidth(context, 39),
                                                                              getHeight(context, 5))),
                                                                      child:
                                                                          Text(
                                                                        "Cancel"
                                                                            .tr,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              : TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
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
                                          color: mainColorBlack,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                            const Icon(Icons
                                                .keyboard_arrow_right_outlined)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getHeight(context, 2),
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                              "Help".tr,
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
                                SizedBox(
                                  height: getHeight(context, 2),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getWidth(context, 5),
                                    ),
                                    child: Container(
                                      height: getHeight(context, 6),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: mainColorRed),
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getWidth(context, 5),
                                    ),
                                    child: Container(
                                      height: getHeight(context, 6),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: mainColorRed),
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              // Image and Username
                              Container(
                                color: mainColorGrey,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Row(
                                  children: [
                                    // image
                                    _image != null
                                        ? Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                width: getWidth(context, 25),
                                                height: getWidth(context, 25),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        mainColorGrey,
                                                    backgroundImage: FileImage(
                                                      File(_image!.path),
                                                    )),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _getImage();
                                                },
                                                icon: Container(
                                                  width: getWidth(context, 8),
                                                  height: getWidth(context, 8),
                                                  decoration: BoxDecoration(
                                                    color: mainColorGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: waitingImage
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: waitingWiget2(
                                                              context),
                                                        )
                                                      : Icon(
                                                          Icons.edit_outlined,
                                                          size: 15,
                                                          color: mainColorWhite,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                  width: getWidth(context, 25),
                                                  height: getWidth(context, 25),
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
                                                      dotenv.env[
                                                              'imageUrlServer']! +
                                                          image,
                                                    ),
                                                  )),
                                              IconButton(
                                                onPressed: () {
                                                  _getImage();
                                                },
                                                icon: Container(
                                                  width: getWidth(context, 8),
                                                  height: getWidth(context, 8),
                                                  decoration: BoxDecoration(
                                                    color: mainColorGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: waitingImage
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: waitingWiget2(
                                                              context),
                                                        )
                                                      : Icon(
                                                          Icons.edit_outlined,
                                                          size: 15,
                                                          color: mainColorWhite,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),

                                    SizedBox(width: getHeight(context, 2)),

                                    // Username
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Bawar Wahid Saber",
                                          //userdata["name"].toString(),
                                          style: TextStyle(
                                              fontFamily: mainFontbold,
                                              fontSize: 16,
                                              color: mainColorWhite),
                                        ),
                                        Text(
                                          "( +964 ) 750 461 2918",
                                          //userdata["phone"].toString(),
                                          style: TextStyle(
                                              fontFamily: mainFontnormal,
                                              fontSize: 14,
                                              color: mainColorWhite),
                                        ),
                                        SizedBox(height: getHeight(context, 1)),
                                        Row(
                                          children: [
                                            Icon(Icons.check_circle,
                                                color: Colors.yellow, size: 14),
                                            SizedBox(width: 5),
                                            Text(
                                              'Golden Account',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Title 1
                              SizedBox(height: getHeight(context, 2)),
                              _titles("Account & Security"),

                              // Account Information
                              _listTiles(Icons.person_outline,
                                  'Account Information', Setting()),

                              // Orders
                              _listTiles(Ionicons.bag_outline, 'Orders',
                                  OrderScreen()),

                              // Refer a friend
                              _listTiles(Icons.person_add_outlined,
                                  'Invite a friend', InvitePage()),

                              // Coin & Reward
                              _listTiles(Icons.monetization_on_outlined,
                                  'Coin & Reward', BlankPage()),

                              // My Voucher
                              _listTiles(Icons.card_giftcard, 'My Voucher',
                                  BlankPage()),

                              // Account Settings
                              _listTiles(Icons.settings_outlined,
                                  'Account Settings', AccountSetting()),

                              // Title 2
                              SizedBox(height: getHeight(context, 2)),
                              _titles("General"),

                              // Terms & Conditions
                              _listTiles(Icons.description_outlined,
                                  "Terms & Conditions", TermsandCondition()),

                              // Privacy Policy
                              _listTiles(Icons.privacy_tip_outlined,
                                  'Privacy Policy', PrivacyScreen()),

                              // Customer Services
                              _listTiles(Icons.support_agent,
                                  'Customer Services', ChatScreen()),

                              // Logout
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    var data = {
                                      "id": userdata["id"].toString()
                                    };
                                    Network(false)
                                        .postData("logout", data, context)
                                        .then((value) {
                                      getStringPrefs("data").then((map) {
                                        Map<String, dynamic> myMap =
                                            json.decode(map);
                                        myMap["islogin"] = false;
                                        myMap["token"] = "";
                                        setStringPrefs(
                                            "data", json.encode(myMap));
                                      });

                                      final cartProvider =
                                          Provider.of<CartProvider>(context,
                                              listen: false);
                                      final product =
                                          Provider.of<productProvider>(context,
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
                                            builder: (context) => NavSwitch()),
                                      );
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    minimumSize: Size(double.infinity, 50),
                                    side: BorderSide(color: Colors.grey),
                                  ),
                                  child: Text('Logout'),
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          );
  }

  Widget _listTiles(IconData icon, String title, Widget destination) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 24),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: mainFontnormal,
                color: mainColorGrey,
                fontSize: 16,
              ),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destination,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 1, thickness: 1),
        ),
      ],
    );
  }

  Widget _titles(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: mainFontbold,
          color: mainColorGrey,
          fontSize: 16,
        ),
      ),
    );
  }
}
