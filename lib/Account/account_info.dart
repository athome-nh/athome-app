import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../Config/my_widget.dart';
import '../Config/property.dart';
import '../Landing/splash_screen.dart';
import '../Network/Network.dart';
import '../controller/productprovider.dart';
import '../main.dart';
import '../map/loction.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
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

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isEdit = false;
  bool colapse = false;
  bool waiting = false;
  bool waitingImage = false;
  String image = "";
  String gender = "Male";
  List<String> GenderType = ['Male', 'Female'];
  String city = "Erbil";
  List<String> items = ['Erbil', 'Sulaymaniyah', 'Duhok', 'Halabja'];
  bool nameE = false;
  bool ageE = false;
  bool cityE = false;
  bool genderE = false;
  String token2 = "";
  TextEditingController age = TextEditingController();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  String selectedLanguage = 'English';
  String selectedItem = 'English';
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
              // AppBar
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    )),
                title: Text(
                  "Account Information".tr,
                ),
              ),

              // body
              body: !isLogin
                  ? loginFirstContainer(context)
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // Image and Username
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
                                              width: getWidth(context, 25),
                                              height: getWidth(context, 25),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
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
                                                )),
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
                                                )),
                                          ],
                                        ),

                                  // Padding(
                                  //   padding: const EdgeInsets.all(8),
                                  //   child: Column(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.center,
                                  //     children: [
                                  //       Text(
                                  //         userdata["name"].toString(),
                                  //         style: TextStyle(
                                  //             fontFamily: mainFontbold,
                                  //             fontSize: 20,
                                  //             color: mainColorBlack),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 3),
                          ),

                          // Name
                          Container(
                            height: getHeight(context, 7),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                              child: TextFormField(
                                controller: nameController,
                                cursorColor: mainColorGrey,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    nameE = false;
                                  });
                                },
                                validator: (value) {
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color:
                                          mainColorGrey, // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: mainColorGrey.withOpacity(
                                          0.5), // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  labelText: "Name".tr,
                                  labelStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontbold),
                                  hintText: "Enter your Name".tr,
                                  hintStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.5),
                                      fontSize: 14,
                                      fontFamily: mainFontnormal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                ),
                              ),
                            ),
                          ),
                          nameE
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: getHeight(context, 0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.circleInfo,
                                        color: mainColorRed.withOpacity(0.7),
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: getWidth(context, 1),
                                      ),
                                      Text(
                                        "Enter your full name".tr,
                                        style: TextStyle(
                                          fontFamily: mainFontbold,
                                          color: mainColorRed.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: getHeight(context, 3),
                          ),

                          // Age
                          Container(
                            height: getHeight(context, 7),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                              child: TextFormField(
                                controller: age,
                                cursorColor: mainColorGrey,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    ageE = false;
                                  });
                                },
                                validator: (value) {
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color:
                                          mainColorGrey, // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: mainColorGrey.withOpacity(
                                          0.5), // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  labelText: "Age".tr,
                                  labelStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontbold),
                                  hintText: "Enter your age".tr,
                                  hintStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.5),
                                      fontSize: 14,
                                      fontFamily: mainFontnormal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                ),
                              ),
                            ),
                          ),
                          ageE
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: getHeight(context, 0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.circleInfo,
                                        color: mainColorRed.withOpacity(0.7),
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: getWidth(context, 1),
                                      ),
                                      Text(
                                        "please, Enter the number only".tr,
                                        style: TextStyle(
                                          fontFamily: mainFontbold,
                                          color: mainColorRed.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: getHeight(context, 3),
                          ),

                          // Phone
                          Container(
                            height: getHeight(context, 7),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                              child: TextFormField(
                                // controller: Phone,
                                cursorColor: mainColorGrey,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    // ageE = false;
                                  });
                                },
                                validator: (value) {
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color:
                                          mainColorGrey, // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: mainColorGrey.withOpacity(
                                          0.5), // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  labelText: "Phone".tr,
                                  labelStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontbold),
                                  hintText: " ".tr,
                                  hintStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.5),
                                      fontSize: 14,
                                      fontFamily: mainFontnormal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 3),
                          ),

                          // City
                          Container(
                            height: getHeight(context, 7),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: mainColorGrey.withOpacity(
                                                0.5),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        labelText: "City".tr,
                                        labelStyle: TextStyle(
                                            color: mainColorBlack,
                                            fontSize: 16,
                                            fontFamily: mainFontbold),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: mainColorBlack.withOpacity(
                                                  0.5),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: city,
                                        isDense: false,
                                        onChanged:(value) {
                                                setState(() {
                                                  city = value.toString();
                                                });
                                              },
                                        items: items.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value.tr,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: mainFontnormal),
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
                          SizedBox(
                            height: getHeight(context, 3),
                          ),

                          // Gender
                          Container(
                            height: getHeight(context, 7),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: mainColorGrey.withOpacity(
                                                0.5),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        labelText: "Gender".tr,
                                        labelStyle: TextStyle(
                                            color: mainColorBlack,
                                            fontSize: 16,
                                            fontFamily: mainFontbold),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: mainColorBlack.withOpacity(
                                                  0.5),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: gender,
                                        isDense: false,
                                        onChanged:(value) {
                                                setState(() {
                                                  gender = value.toString();
                                                });
                                              },
                                        items: GenderType.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value.tr,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: mainFontnormal),
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
                          SizedBox(
                            height: getHeight(context, 3),
                          ),

                          // Address
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
                                      color: mainColorGrey.withOpacity(0.5),
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
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
                        ],
                      ),
                    ),
            ),
          );
  }
}
