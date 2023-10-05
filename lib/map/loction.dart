import 'package:athome/Config/property.dart';
import 'package:athome/main.dart';
import 'package:athome/map/maps.dart';
import 'package:flutter/material.dart';

class location_screen extends StatefulWidget {
  const location_screen({super.key});

  @override
  State<location_screen> createState() => _location_screenState();
}

class _location_screenState extends State<location_screen> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getHeight(context, 70),
                width: getWidth(context, 100),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(bottom: getHeight(context, 2)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: mainColorLightGrey,
                                borderRadius: BorderRadius.circular(5)),
                            child: ListTile(
                              title: Text(
                                "Home",
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontSize: 14,
                                    fontFamily: mainFontbold),
                              ),
                              trailing: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Change",
                                    style: TextStyle(
                                        color: mainColorRed,
                                        fontFamily: mainFontnormal),
                                  )),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Maps_screen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: mainColorWhite,
                      size: 25,
                    ),
                    Text(
                      "Add location",
                      style: TextStyle(
                          color: mainColorWhite,
                          fontSize: 18,
                          fontFamily: mainFontbold),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColorRed,
                  fixedSize: Size(getWidth(context, 85), getHeight(context, 6)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
