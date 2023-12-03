import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  LocationPermission permission =
                      await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    // Handle case where the user denied access to their location
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Map_screen()),
                  );
                },
                icon: Icon(
                  Icons.add,
                ))
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              )),
          centerTitle: true,
          title: Text(
            "Locations".tr,
          ),
        ),
        body: productrovider.location.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset("assets/Victors/empty_location.png"),
                  ),

                  //textCheck
                ],
              )
            : SingleChildScrollView(
                child: SizedBox(
                  height: getHeight(context, 100),
                  width: getWidth(context, 100),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: productrovider.location.length,
                        itemBuilder: (BuildContext context, int index) {
                          final location = productrovider.location[index];
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: getHeight(context, 2)),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(children: [
                                    location.type.toString().contains("Home")
                                        ? Icon(
                                            Ionicons.home_outline,
                                            color: mainColorGrey,
                                            size: 35,
                                          )
                                        : Icon(
                                            Ionicons.business_outline,
                                            color: mainColorGrey,
                                            size: 35,
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          location.name!,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontSize: 22,
                                              fontFamily: mainFontnormal),
                                        ),
                                        Text(
                                          location.area!,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontSize: 12,
                                              fontFamily: mainFontnormal),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          var data = {"id": location.id!};
                                          Network(false)
                                              .postData("delete_location", data,
                                                  context)
                                              .then((value) {
                                            if (value != "") {
                                              if (value["code"] == "201") {
                                                Provider.of<productProvider>(
                                                        context,
                                                        listen: false)
                                                    .deletelocation(
                                                        location.id!);
                                                toastShort(
                                                    "Delete location success"
                                                        .tr);
                                              }
                                            }
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                Colors.transparent),
                                        child: Text(
                                          "Delete".tr,
                                          style: TextStyle(
                                              color: mainColorRed,
                                              fontFamily: mainFontnormal),
                                        )),
                                  ]),
                                ),
                                const Divider()
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
      ),
    );
  }
}
