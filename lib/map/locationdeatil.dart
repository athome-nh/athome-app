import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Config/value.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/location/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';

class location_Deatil extends StatefulWidget {
  double longitude = 0.0;
  double latitude = 0.0;
  String name = "";
  String housenumber = "";
  location_Deatil(this.longitude, this.latitude, this.name, this.housenumber,
      {super.key});

  @override
  State<location_Deatil> createState() => _location_DeatilState();
}

class _location_DeatilState extends State<location_Deatil> {
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController number2Controller = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool nameE = false;
  bool typeE = false;
  bool floorE = false;
  bool numberE = false;
  bool number2E = false;
  List<String> items = [
    'House',
    'Office',
    'Apartment',
  ];
  String type = 'House';
  bool waiting = false;
  @override
  void initState() {
    if (isLogin) {
      phoneController.text = userdata["phone"].toString().substring(4);
    }
    numberController.text = widget.housenumber;
    streetController.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Locations".tr,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        height: getHeight(context, 15),
                        width: getWidth(context, 100),
                        child: MapWidget(
                          key: const ValueKey("mapWidget"),
                          resourceOptions:
                              ResourceOptions(accessToken: MAPBOX_ACCESS_TOKEN),
                          onMapCreated: (controller) {
                            controller.gestures.updateSettings(GesturesSettings(
                                rotateEnabled: false,
                                quickZoomEnabled: false,
                                doubleTapToZoomInEnabled: false,
                                doubleTouchToZoomOutEnabled: false,
                                pinchToZoomEnabled: false,
                                scrollDecelerationEnabled: false,
                                scrollEnabled: false,
                                focalPoint: ScreenCoordinate(
                                    x: widget.latitude, y: widget.longitude)));
                            controller.location.updateSettings(
                                LocationComponentSettings(
                                    enabled: true, pulsingEnabled: true));
                            controller.flyTo(
                                CameraOptions(
                                    center: Point(
                                            coordinates: Position(
                                                widget.longitude,
                                                widget.latitude))
                                        .toJson(),
                                    zoom: 18,
                                    bearing: 0,
                                    pitch: 15),
                                MapAnimationOptions(
                                    duration: 1000, startDelay: 0));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: nameController,
                      cursorColor: mainColorBlack,
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
                            color: mainColorBlack, // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorBlack
                                .withOpacity(0.5), // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        labelText: "Name".tr,
                        labelStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: mainFontnormal),
                        hintText: "Add name".tr,
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                      ),
                    ),
                    nameE
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: getHeight(context, 0.5),
                            ),
                            child: Text(
                              "Add name location".tr,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: mainFontnormal,
                                color: mainColorRed.withOpacity(0.8),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: streetController,
                      cursorColor: mainColorBlack,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorBlack, // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorBlack
                                .withOpacity(0.5), // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        labelText: "Area".tr,
                        labelStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: mainFontnormal),
                        hintText: "Add Area".tr,
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: mainColorBlack.withOpacity(
                                      0.5), // Customize border color
                                  width: 1.0, // Customize border width
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              labelText: "Type Building".tr,
                              labelStyle: TextStyle(
                                  color: mainColorBlack,
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: mainColorBlack.withOpacity(
                                        0.5), // Customize border color
                                    width: 1.0, // Customize border width
                                  ),
                                  borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: type,
                              isDense: true,
                              onChanged: (value) {
                                setState(() {
                                  typeE = false;
                                  type = value.toString();
                                });
                              },
                              items: items.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value.tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: mainFontnormal),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    type == "Apartment"
                        ? Column(
                            children: [
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                              TextFormField(
                                maxLines: 1,
                                controller: floorController,
                                cursorColor: mainColorBlack,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    floorE = false;
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
                                          mainColorBlack, // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: mainColorBlack.withOpacity(
                                          0.5), // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  labelText: "Floor number".tr,
                                  labelStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  hintText: "Floor number".tr,
                                  hintStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.5),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                ),
                              ),
                              floorE
                                  ? Align(
                                      alignment: lang == "en"
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: getHeight(context, 0.5),
                                        ),
                                        child: Text(
                                          "Enter floor number".tr,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: mainFontnormal,
                                            color:
                                                mainColorRed.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: getHeight(context, 2),
                              ),
                              TextFormField(
                                maxLines: 1,
                                controller: number2Controller,
                                cursorColor: mainColorBlack,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    number2E = false;
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
                                          mainColorBlack, // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: mainColorBlack.withOpacity(
                                          0.5), // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  labelText: "building name/number".tr,
                                  labelStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  hintText: "building name/number".tr,
                                  hintStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.5),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                ),
                              ),
                              number2E
                                  ? Align(
                                      alignment: lang == "en"
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: getHeight(context, 0.5),
                                        ),
                                        child: Text(
                                          "Enter building name/number".tr,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: mainFontnormal,
                                            color:
                                                mainColorRed.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : type == "Office"
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: getHeight(context, 2),
                                  ),
                                  TextFormField(
                                    maxLines: 1,
                                    controller: floorController,
                                    cursorColor: mainColorBlack,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setState(() {
                                        floorE = false;
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
                                              mainColorBlack, // Customize border color
                                          width: 1.0, // Customize border width
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: mainColorBlack.withOpacity(
                                              0.5), // Customize border color
                                          width: 1.0, // Customize border width
                                        ),
                                      ),
                                      labelText: "Floor number".tr,
                                      labelStyle: TextStyle(
                                          color:
                                              mainColorBlack.withOpacity(0.8),
                                          fontSize: 16,
                                          fontFamily: mainFontnormal),
                                      hintText: "Floor number".tr,
                                      hintStyle: TextStyle(
                                          color:
                                              mainColorBlack.withOpacity(0.5),
                                          fontSize: 16,
                                          fontFamily: mainFontnormal),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                    ),
                                  ),
                                  floorE
                                      ? Align(
                                          alignment: lang == "en"
                                              ? Alignment.bottomLeft
                                              : Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: getHeight(context, 0.5),
                                            ),
                                            child: Text(
                                              "Enter floor number".tr,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: mainFontnormal,
                                                color: mainColorRed
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: getHeight(context, 2),
                                  ),
                                  TextFormField(
                                    maxLines: 1,
                                    controller: number2Controller,
                                    cursorColor: mainColorBlack,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setState(() {
                                        number2E = false;
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
                                              mainColorBlack, // Customize border color
                                          width: 1.0, // Customize border width
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: mainColorBlack.withOpacity(
                                              0.5), // Customize border color
                                          width: 1.0, // Customize border width
                                        ),
                                      ),
                                      labelText: "building name/number".tr,
                                      labelStyle: TextStyle(
                                          color:
                                              mainColorBlack.withOpacity(0.8),
                                          fontSize: 16,
                                          fontFamily: mainFontnormal),
                                      hintText: "building name/number".tr,
                                      hintStyle: TextStyle(
                                          color:
                                              mainColorBlack.withOpacity(0.5),
                                          fontSize: 16,
                                          fontFamily: mainFontnormal),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                    ),
                                  ),
                                  number2E
                                      ? Align(
                                          alignment: lang == "en"
                                              ? Alignment.bottomLeft
                                              : Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: getHeight(context, 0.5),
                                            ),
                                            child: Text(
                                              "Enter building name/number".tr,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: mainFontnormal,
                                                color: mainColorRed
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              )
                            : const SizedBox(),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: numberController,
                      cursorColor: mainColorBlack,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          numberE = false;
                        });
                      },
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorBlack, // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorBlack
                                .withOpacity(0.5), // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        labelText: lang == "en"
                            ? "${type.tr} ${"number".tr}"
                            : "number".tr + type.tr,
                        labelStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: mainFontnormal),
                        hintText: lang == "en"
                            ? "${type.tr} ${"number".tr}"
                            : "number".tr + type.tr,
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                      ),
                    ),
                    numberE
                        ? Align(
                            alignment: lang == "en"
                                ? Alignment.bottomLeft
                                : Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: getHeight(context, 0.5),
                              ),
                              child: Text(
                                "Enter number".tr,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: mainFontnormal,
                                  color: mainColorRed.withOpacity(0.8),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: phoneController,
                      cursorColor: mainColorBlack,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorBlack, // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: mainColorBlack
                                .withOpacity(0.5), // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        labelText: "Phone number".tr,
                        suffixText: lang != "en" ? " | +964" : "",
                        prefixText: lang == "en" ? "+964 | " : "",
                        suffixStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.8),
                            fontFamily: mainFontnormal),
                        prefixStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.8),
                            fontFamily: mainFontnormal),
                        labelStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: mainFontnormal),
                        hintText: "Add phone number".tr,
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: getWidth(context, 40),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: mainColorRed,
                              ),
                              child: Text(
                                "Cancel".tr,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getWidth(context, 40),
                            child: TextButton(
                              onPressed: waiting
                                  ? null
                                  : () async {
                                      if (nameController.text.isEmpty) {
                                        setState(() {
                                          nameE = true;
                                        });
                                        return;
                                      }

                                      if (floorController.text.isEmpty &&
                                          (type == 'Office' ||
                                              type == 'Apartment')) {
                                        setState(() {
                                          floorE = true;
                                        });
                                        return;
                                      }
                                      if (number2Controller.text.isEmpty &&
                                          (type == 'Office' ||
                                              type == 'Apartment')) {
                                        setState(() {
                                          number2E = true;
                                        });
                                        return;
                                      }
                                      if (numberController.text.isEmpty) {
                                        setState(() {
                                          numberE = true;
                                        });
                                        return;
                                      }

                                      setState(() {
                                        waiting = true;
                                      });
                                      var data = {
                                        "id": userdata["id"],
                                        "longitude": widget.longitude,
                                        "latitude": widget.latitude,
                                        "area": streetController.text,
                                        "name": nameController.text,
                                        "floor": floorController.text,
                                        "number": numberController.text,
                                        "phone": phoneController.text,
                                        "building_name": number2Controller.text,
                                        "type": type,
                                        "in_range": 1,
                                      };
                                      Network(false)
                                          .postData("location", data, context)
                                          .then((value) {
                                        if (value != "") {
                                          if (value["code"] == "201") {
                                            Locationuser loc =
                                                Locationuser.fromMap(
                                                    value["data"]);

                                            final productrovider =
                                                Provider.of<productProvider>(
                                                    context,
                                                    listen: false);
                                            productrovider.getuserdata(
                                                userdata["id"].toString());
                                            productrovider.addlocation(loc);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          } else {
                                            setState(() {
                                              waiting = false;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            waiting = false;
                                          });
                                        }
                                      });
                                    },
                              style: TextButton.styleFrom(),
                              child: Text(
                                "Save".tr,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              waiting ? waitingWiget(context) : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
