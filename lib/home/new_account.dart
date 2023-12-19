import 'dart:io';

import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Config/value.dart';

import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Account_new extends StatefulWidget {
  const Account_new({super.key});

  @override
  State<Account_new> createState() => _Account_newState();
}

class _Account_newState extends State<Account_new> {
  final picker = ImagePicker();
  XFile? _image;
  bool waiting = false;
  bool waitingImage = false;
  String image = "";
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

  void initState() {
    // selectedItem = lang == "en"
    //     ? "English"
    //     : lang == "ar"
    //         ? "Arabic"
    //         : "Kurdish";
    if (isLogin && userdata.isNotEmpty) {
      // nameController.text = userdata["name"];
      // ageController.text = userdata["age"].toString();
      // gender = userdata["gender"];
      image = userdata["img"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorGrey.withOpacity(0.1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Account".tr,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: Column(children: [
                      // image
                      _image != null
                          ? Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: getWidth(context, 40),
                                  height: getWidth(context, 40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      File(_image!.path),
                                      width: getWidth(context, 40),
                                      height: getWidth(context, 40),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _getImage();
                                    },
                                    icon: Container(
                                      width: getWidth(context, 15),
                                      height: getWidth(context, 15),
                                      decoration: BoxDecoration(
                                        color: mainColorGrey,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: waitingImage
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: waitingWiget2(context),
                                            )
                                          : Icon(
                                              Icons.edit_outlined,
                                              color: mainColorWhite,
                                            ),
                                    )),
                              ],
                            )
                          : Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    imageUrlServer + image,
                                    fit: BoxFit
                                        .fill, // Customize the BoxFit property
                                    width: 75,
                                    height: 75,
                                  ),
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
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: waitingImage
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: waitingWiget2(context),
                                            )
                                          : Icon(
                                              Icons.edit_outlined,
                                              color: mainColorWhite,
                                            ),
                                    )),
                              ],
                            ),
                    ]),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
