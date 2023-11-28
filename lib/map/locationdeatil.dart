import 'package:athome/Config/property.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/landing/splash_screen.dart';
import 'package:athome/main.dart';
import 'package:athome/model/location/location.dart';
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
    'Home',
    'Office',
    'Apartment',
  ];
  String type = 'Home';
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
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColorWhite,
          centerTitle: true,
          title: Text(
            "Locations".tr,
            style: TextStyle(
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 22),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                            pinchToZoomEnabled: true,
                            focalPoint: ScreenCoordinate(
                                x: widget.latitude, y: widget.longitude)));
                        controller.location.updateSettings(
                            LocationComponentSettings(
                                enabled: true, pulsingEnabled: true));
                        controller.flyTo(
                            CameraOptions(
                                center: Point(
                                        coordinates: Position(
                                            widget.longitude, widget.latitude))
                                    .toJson(),
                                zoom: 18,
                                bearing: 0,
                                pitch: 15),
                            MapAnimationOptions(duration: 1000, startDelay: 0));
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
                        color: mainColorGrey, // Customize border color
                        width: 1.0, // Customize border width
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: mainColorGrey
                            .withOpacity(0.5), // Customize border color
                        width: 1.0, // Customize border width
                      ),
                    ),
                    labelText: "Name".tr,
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: "Add name".tr,
                    hintStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.5),
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
                  cursorColor: mainColorGrey,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: mainColorGrey, // Customize border color
                        width: 1.0, // Customize border width
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: mainColorGrey
                            .withOpacity(0.5), // Customize border color
                        width: 1.0, // Customize border width
                      ),
                    ),
                    labelText: "Area".tr,
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: "Add Area".tr,
                    hintStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.5),
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
                              color: mainColorGrey
                                  .withOpacity(0.5), // Customize border color
                              width: 1.0, // Customize border width
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Type Building".tr,
                          labelStyle: TextStyle(
                              color: mainColorGrey,
                              fontSize: 16,
                              fontFamily: mainFontnormal),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColorGrey
                                    .withOpacity(0.5), // Customize border color
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
                                value,
                                style: TextStyle(
                                    fontSize: 16, fontFamily: mainFontnormal),
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
                            cursorColor: mainColorGrey,
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
                                      mainColorGrey, // Customize border color
                                  width: 1.0, // Customize border width
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: mainColorGrey.withOpacity(
                                      0.5), // Customize border color
                                  width: 1.0, // Customize border width
                                ),
                              ),
                              labelText: "Floor number".tr,
                              labelStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              hintText: "Floor number".tr,
                              hintStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.5),
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                            ),
                          ),
                          floorE
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: getHeight(context, 0.5),
                                  ),
                                  child: Text(
                                    "Enter floor number".tr,
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
                            controller: number2Controller,
                            cursorColor: mainColorGrey,
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
                                      mainColorGrey, // Customize border color
                                  width: 1.0, // Customize border width
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: mainColorGrey.withOpacity(
                                      0.5), // Customize border color
                                  width: 1.0, // Customize border width
                                ),
                              ),
                              labelText: "building name/number".tr,
                              labelStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              hintText: "building name/number".tr,
                              hintStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.5),
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                            ),
                          ),
                          number2E
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    top: getHeight(context, 0.5),
                                  ),
                                  child: Text(
                                    "Enter building name/number".tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: mainFontnormal,
                                      color: mainColorRed.withOpacity(0.8),
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
                                cursorColor: mainColorGrey,
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
                                          mainColorGrey, // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: mainColorGrey.withOpacity(
                                          0.5), // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  labelText: "Floor number".tr,
                                  labelStyle: TextStyle(
                                      color: mainColorGrey.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  hintText: "Floor number".tr,
                                  hintStyle: TextStyle(
                                      color: mainColorGrey.withOpacity(0.5),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                ),
                              ),
                              floorE
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: getHeight(context, 0.5),
                                      ),
                                      child: Text(
                                        "Enter floor number".tr,
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
                                controller: number2Controller,
                                cursorColor: mainColorGrey,
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
                                          mainColorGrey, // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: mainColorGrey.withOpacity(
                                          0.5), // Customize border color
                                      width: 1.0, // Customize border width
                                    ),
                                  ),
                                  labelText: "building name/number".tr,
                                  labelStyle: TextStyle(
                                      color: mainColorGrey.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  hintText: "building name/number".tr,
                                  hintStyle: TextStyle(
                                      color: mainColorGrey.withOpacity(0.5),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                ),
                              ),
                              number2E
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: getHeight(context, 0.5),
                                      ),
                                      child: Text(
                                        "Enter building name/number".tr,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: mainFontnormal,
                                          color: mainColorRed.withOpacity(0.8),
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
                  cursorColor: mainColorGrey,
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
                        color: mainColorGrey, // Customize border color
                        width: 1.0, // Customize border width
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: mainColorGrey
                            .withOpacity(0.5), // Customize border color
                        width: 1.0, // Customize border width
                      ),
                    ),
                    labelText: type + "number".tr,
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: type + "number".tr,
                    hintStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.5),
                        fontSize: 14,
                        fontFamily: mainFontnormal),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                  ),
                ),
                numberE
                    ? Padding(
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
                  cursorColor: mainColorGrey,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: mainColorGrey, // Customize border color
                        width: 1.0, // Customize border width
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: mainColorGrey
                            .withOpacity(0.5), // Customize border color
                        width: 1.0, // Customize border width
                      ),
                    ),
                    labelText: "Phone number".tr,
                    prefixText: "+964 | ",

                    prefixStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontFamily: mainFontnormal),
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: "Add phone number".tr,
                    hintStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.5),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(

                            // fixedSize: Size(
                            //     getWidth(context, 35), getHeight(context, 6)),
                            ),
                        child: Text(
                          "Cancel".tr,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // if (nameController.text.isEmpty) {
                          //   setState(() {
                          //     nameE = true;
                          //   });
                          //   return;
                          // }

                          // if (floorController.text.isEmpty &&
                          //     (type == 'Office' || type == 'Apartment')) {
                          //   setState(() {
                          //     floorE = true;
                          //   });
                          //   return;
                          // }
                          // if (numberController.text.isEmpty) {
                          //   setState(() {
                          //     numberE = true;
                          //   });
                          //   return;
                          // }
                          // if (number2Controller.text.isEmpty &&
                          //     (type == 'Office' || type == 'Apartment')) {
                          //   setState(() {
                          //     number2E = true;
                          //   });
                          //   return;
                          // }

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
                                    Locationuser.fromMap(value["data"]);

                                final productrovider =
                                    Provider.of<productProvider>(context,
                                        listen: false);
                                productrovider
                                    .getDataUser(userdata["id"].toString());
                                productrovider.addlocation(loc);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: mainColorRed,
                          // fixedSize: Size(
                          //     getWidth(context, 35), getHeight(context, 6)),
                        ),
                        child: Text(
                          "Save".tr,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
