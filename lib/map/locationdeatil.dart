import 'package:athome/Config/property.dart';
import 'package:athome/home/NavSwitch.dart';
import 'package:athome/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class location_Deatil extends StatefulWidget {
  String longitude = "";
  String latitude = "";
  location_Deatil(this.longitude, this.latitude);

  @override
  State<location_Deatil> createState() => _location_DeatilState();
}

class _location_DeatilState extends State<location_Deatil> {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController floorController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool nameE = false;
  bool typeE = false;
  bool floorE = false;
  bool numberE = false;

  List<String> items = [
    'Home',
    'Office',
    'Apartment',
  ];
  String type = 'Home';
  @override
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    hintText: "Add name location",
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
                              labelText: type + " floor",
                              labelStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.8),
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              hintText: type + " floor",
                              hintStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.5),
                                  fontSize: 16,
                                  fontFamily: mainFontnormal),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                            ),
                          ),
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
                                  labelText: type + " floor",
                                  labelStyle: TextStyle(
                                      color: mainColorGrey.withOpacity(0.8),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  hintText: type + " floor",
                                  hintStyle: TextStyle(
                                      color: mainColorGrey.withOpacity(0.5),
                                      fontSize: 16,
                                      fontFamily: mainFontnormal),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
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
                    labelText: "Phone",
                    prefixText: "+964 | ",
                    prefixStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontFamily: mainFontnormal),
                    labelStyle: TextStyle(
                        color: mainColorGrey.withOpacity(0.8),
                        fontSize: 16,
                        fontFamily: mainFontnormal),
                    hintText: "Add number phone ",
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
                        onPressed: () {
                          if (nameController.text.isEmpty) {
                            setState(() {
                              nameE = true;
                            });
                            return;
                          }

                          if (floorController.text.isEmpty &&
                              (type == 'Office' || type == 'Apartment')) {
                            setState(() {
                              floorE = true;
                            });
                            return;
                          }
                          if (numberController.text.isEmpty) {
                            setState(() {
                              numberE = true;
                            });
                            return;
                          }
                          var data = {
                            "id": userData["id"],
                            "location": widget.longitude.toString() +
                                "," +
                                widget.latitude.toString()
                          };
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
