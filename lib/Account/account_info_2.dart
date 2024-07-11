import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

class AccountInfo2 extends StatefulWidget {
  const AccountInfo2({super.key});

  @override
  State<AccountInfo2> createState() => _AccountInfo2State();
}

class _AccountInfo2State extends State<AccountInfo2> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final picker = ImagePicker();
  XFile? _image;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isEdit = false;
  bool waiting = false;

  String image = "";
  String gender = "Male";
  String city = "Erbil";
  String selectedItem = 'English';

  List<String> genderOptions = ['Male', 'Female'];
  List<String> cityOptions = ['Erbil', 'Sulaymaniyah', 'Duhok', 'Halabja'];

  @override
  void initState() {
    super.initState();
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
  }

  Future<void> _getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _saveProfile() async {
    setState(() {
      waiting = true;
    });
    if (_image != null) {
      Map<String, String> body = {"id": userdata["id"].toString()};
      Network(false)
          .addImage("profileImg", body, _image!.path)
          .then((value) {});
    }

    var data = {
      "id": userdata["id"],
      "name": nameController.text,
      "age": ageController.text,
      "gender": gender,
    };
    Network(false).postData("profile", data, context).then((value) {
      print(value);
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
  }

  void _cancelEdit() {
    setState(() {
      isEdit = false;
      nameController.text = userdata["name"];
      ageController.text = userdata["age"].toString();
      phoneController.text = userdata["phone"].toString();
      gender = userdata["gender"];
      image = userdata["img"];
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<productProvider>(context, listen: true).nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              body: !isLogin
                  ? loginFirstContainer(context)
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profileHeader(),
                          SizedBox(height: getHeight(context, 3)),
                          profileFields(),
                          SizedBox(height: getHeight(context, 8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isEdit ? cancelButton() : backButton(),
                              SizedBox(width: getHeight(context, 2)),
                              isEdit ? saveButton() : editButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          );
  }

  Widget profileHeader() {
    return Container(
      height: getHeight(context, 25),
      decoration: BoxDecoration(
        color: mainColorGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          profileImage(),
          SizedBox(width: getHeight(context, 4)),
          profileDetails(),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Container(
      width: getWidth(context, 30),
      height: getWidth(context, 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: mainColorWhite),
      child: _image != null
          ? Stack(
              alignment: Alignment.bottomRight,
              children: [
                // CircleAvatar (Edit)
                Container(
                  width: getWidth(context, 30),
                  height: getWidth(context, 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    backgroundColor: mainColorGrey,
                    backgroundImage: FileImage(
                      File(_image!.path),
                    ),
                  ),
                ),

                // Icon (Edit)
                isEdit
                    ? IconButton(
                        onPressed: () {
                          _getImage();
                        },
                        icon: Container(
                          width: getWidth(context, 9),
                          height: getWidth(context, 9),
                          decoration: BoxDecoration(
                            color: mainColorRed,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            size: 15,
                            color: mainColorWhite,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            )
          : Stack(
              alignment: Alignment.bottomRight,
              children: [
                // CircleAvatar
                Container(
                    width: getWidth(context, 30),
                    height: getWidth(context, 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        dotenv.env['imageUrlServer']! + userdata["img"],
                      ),
                      backgroundColor: mainColorWhite,
                      // foregroundImage: AssetImage(
                      //   "assets/images/test1.png",
                      // ),
                    )),
                isEdit
                    ? IconButton(
                        onPressed: () {
                          _getImage();
                        },
                        icon: Container(
                          width: getWidth(context, 9),
                          height: getWidth(context, 9),
                          decoration: BoxDecoration(
                            color: mainColorRed,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            size: 15,
                            color: mainColorWhite,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  }

  Widget profileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Image.asset("assets/rank/IV.png",
                width: getWidth(context, 6), height: getWidth(context, 6)),
            SizedBox(width: getHeight(context, 1)),
            Text(
              userdata["name"].toString(),
              style: TextStyle(
                  fontFamily: mainFontbold,
                  fontSize: 16,
                  color: mainColorWhite),
            ),
          ],
        ),
        SizedBox(height: getHeight(context, 1)),
        Text(
          userdata["phone"].toString(),
          style: TextStyle(
              fontFamily: mainFontnormal, fontSize: 14, color: mainColorWhite),
        ),
        SizedBox(height: getHeight(context, 1)),
        pointsContainer(),
      ],
    );
  }

  Widget pointsContainer() {
    return Container(
      height: getHeight(context, 4),
      width: getWidth(context, 20),
      decoration: BoxDecoration(
        border: Border.all(color: mainColorGrey.withOpacity(0.3)),
        color: mainColorWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            userdata["point"].toString(),
            style: TextStyle(
                fontSize: 16, color: mainColorBlack, fontFamily: mainFontbold),
          ),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/App-Icon.png"),
            radius: getHeight(context, 1),
          ),
        ],
      ),
    );
  }

  Widget profileFields() {
    return Column(
      children: [
        SizedBox(height: getHeight(context, 2)),
        textFields(Ionicons.person_outline, 'Enter Your Name', nameController,
            userdata["name"]),
        SizedBox(height: getHeight(context, 2)),
        textFields(Ionicons.calendar_outline, 'Enter Your Age', ageController,
            userdata["age"].toString()),
        SizedBox(height: getHeight(context, 2)),
        dropdownField(Ionicons.male_female_outline, 'Select Gender',
            genderOptions, gender),
        SizedBox(height: getHeight(context, 2)),
        dropdownField(
            Ionicons.business_outline, 'Select City', cityOptions, city),
        SizedBox(height: getHeight(context, 2)),
        textFieldsLock(Ionicons.call_outline, 'Enter Your Phone',
            phoneController, userdata["phone"].toString()),
        SizedBox(height: getHeight(context, 2)),
      ],
    );
  }

  Widget textFields(IconData icon, String label,
      TextEditingController controller, String initialValue) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getHeight(context, 2)),
          child: Row(
            children: [
              Icon(icon, size: 24),
              SizedBox(width: getHeight(context, 2)),
              Expanded(
                child: isEdit
                    ? TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: label,
                          hintStyle: TextStyle(
                            fontFamily: mainFontnormal,
                            color: mainColorGrey,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      )
                    : TextField(
                        controller: controller,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: label,
                          hintStyle: TextStyle(
                            fontFamily: mainFontnormal,
                            color: mainColorBlack,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
              ),
              isEdit ? Icon(Icons.edit_outlined) : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: getHeight(context, 7), right: getHeight(context, 2)),
          child: Divider(height: 1, thickness: 1),
        ),
      ],
    );
  }

  Widget textFieldsLock(IconData icon, String label,
      TextEditingController controller, String initialValue) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getHeight(context, 2)),
          child: Row(
            children: [
              Icon(icon, size: 24),
              SizedBox(width: getHeight(context, 2)),
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: label,
                    hintStyle: TextStyle(
                      fontFamily: mainFontnormal,
                      color: mainColorBlack,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: getHeight(context, 7), right: getHeight(context, 2)),
          child: Divider(height: 1, thickness: 1),
        ),
      ],
    );
  }

  Widget dropdownField(
      IconData icon, String label, List<String> options, String value) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getHeight(context, 2)),
          child: Row(
            children: [
              Icon(icon, size: 24),
              SizedBox(width: getHeight(context, 2)),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: mainColorGrey.withOpacity(0.3))),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: value,
                    isDense: false,
                    decoration: InputDecoration(
                      hintText: label,
                      hintStyle: TextStyle(
                        fontFamily: mainFontnormal,
                        color: mainColorGrey,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.zero, // Adjust padding as needed
                    ),
                    onChanged: isEdit
                        ? (newValue) => setState(() => value = newValue!)
                        : null,
                    items: options.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: mainFontnormal,
                            color: isEdit
                                ? mainColorBlack
                                : mainColorBlack.withOpacity(0.5),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget saveButton() {
    return TextButton(
      onPressed: waiting ? null : _saveProfile,
      style: TextButton.styleFrom(
        fixedSize: Size(getWidth(context, 40), getHeight(context, 5)),
        side: BorderSide(color: mainColorGrey.withOpacity(0.5), width: 1),
      ),
      child: Text(
        "Save".tr,
        style: TextStyle(fontFamily: mainFontbold, fontSize: 16),
      ),
    );
  }

  Widget cancelButton() {
    return TextButton(
      onPressed: _cancelEdit,
      style: TextButton.styleFrom(
        fixedSize: Size(getWidth(context, 40), getHeight(context, 5)),
        backgroundColor: mainColorRed,
      ),
      child: Text(
        "Cancel".tr,
        style: TextStyle(
            fontFamily: mainFontbold, fontSize: 16, color: mainColorWhite),
      ),
    );
  }

  Widget backButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        fixedSize: Size(getWidth(context, 40), getHeight(context, 5)),
        backgroundColor: mainColorRed,
      ),
      child: Text(
        "back".tr,
        style: TextStyle(
            fontFamily: mainFontbold, fontSize: 16, color: mainColorWhite),
      ),
    );
  }

  Widget editButton() {
    return TextButton(
      onPressed: () => setState(() => isEdit = true),
      style: TextButton.styleFrom(
        fixedSize: Size(getWidth(context, 40), getHeight(context, 5)),
        side: BorderSide(color: mainColorGrey.withOpacity(0.5), width: 1),
      ),
      child: Text(
        "Edit".tr,
        style: TextStyle(
            fontFamily: mainFontbold, fontSize: 16, color: mainColorWhite),
      ),
    );
  }
}
