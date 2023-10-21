import 'package:athome/Config/property.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/model/location/location.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class location_Deatil extends StatefulWidget {
  double longitude = 0.0;
  double latitude = 0.0;
  location_Deatil(this.longitude, this.latitude);

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
      phoneController.text = userData["phone"].toString().substring(4);
    }
    getstreet();
    super.initState();
  }

  getstreet() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.latitude, widget.longitude);
    print(placemarks);
    if (placemarks != null && placemarks.isNotEmpty) {
      // Use subLocality if available, otherwise use locality
      streetController.text = placemarks[2].street.toString();
    } else {}
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
            "Locations",
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
                  child: Container(
                    height: getHeight(context, 15),
                    width: getWidth(context, 100),
                    child: GoogleMap(
                      scrollGesturesEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.latitude, widget.longitude),
                        zoom: 19.0, // Adjust the zoom level as needed
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        //mapController = controller;
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId('location_marker'),
                          position: LatLng(widget.latitude, widget.longitude),
                          infoWindow: InfoWindow(
                            title: 'Location',
                          ),
                        ),
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
                  validator: (value) {},
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
                    labelText: "Name",
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: "Add name ",
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
                          "Add name location",
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
                  validator: (value) {},
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
                    labelText: "Area",
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: "Add Area",
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
                          labelText: "Type Building",
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
                            validator: (value) {},
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
                              labelText: "Floor number",
                              labelStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              hintText: "Floor number",
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
                                    "Enter floor number",
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
                            validator: (value) {},
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
                              labelText: "building name/number",
                              labelStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              hintText: "building name/number",
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
                                    "Enter building name/number",
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
                                validator: (value) {},
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
                                  labelText: "Floor number",
                                  labelStyle: TextStyle(
                                      color: mainColorGrey.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  hintText: "Floor number",
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
                                        "Enter floor number",
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
                                validator: (value) {},
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
                                  labelText: "building name/number",
                                  labelStyle: TextStyle(
                                      color: mainColorGrey.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  hintText: "building name/number",
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
                                        "Enter building name/number",
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
                        : SizedBox(),
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
                  validator: (value) {},
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
                    labelText: type + " number",
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: type + " number",
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
                          "Enter number",
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
                  validator: (value) {},
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
                    labelText: "Phone number",
                    prefixText: "+964 | ",

                    prefixStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontFamily: mainFontnormal),
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: "Add phone number ",
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
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: mainColorWhite,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColorRed,
                          fixedSize: Size(
                              getWidth(context, 35), getHeight(context, 6)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
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
                            "id": userData["id"],
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

                                Provider.of<productProvider>(context,
                                        listen: false)
                                    .addlocation(loc);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            }
                          });
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: mainColorWhite,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColorRed,
                          fixedSize: Size(
                              getWidth(context, 35), getHeight(context, 6)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
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
