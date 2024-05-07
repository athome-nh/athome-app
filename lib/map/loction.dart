import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/map/map_screen.dart';
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
                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.all(8),
                            color: mainColorWhite,
                            child: Column(
                              children: [
                                ListTile(
                                  trailing: TextButton(
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
                                                  .deletelocation(location.id!);
                                              toastShort(
                                                  "Delete location success".tr);
                                            }
                                          }
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.transparent),
                                      child: Text(
                                        "Delete".tr,
                                        style: TextStyle(
                                            color: mainColorRed,
                                            fontFamily: mainFontnormal),
                                      )),
                                  leading:
                                      location.type.toString().contains("House")
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
                                  title: Text(
                                    location.name!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: mainFontbold,
                                        color: mainColorBlack),
                                  ),
                                  subtitle: Text(
                                    location.area!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: mainFontnormal,
                                        color: mainColorBlack),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: getWidth(context, 4)),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       TextButton.icon(
                                //         onPressed: () {

                                //         },
                                //         icon: Icon(
                                //           Icons.repeat,
                                //           color: mainColorGrey,
                                //         ), // Add your desired icon
                                //         style: TextButton.styleFrom(
                                //             backgroundColor: Colors.transparent,
                                //             fixedSize: Size(
                                //                 getWidth(context, 30),
                                //                 getHeight(context, 3))),
                                //         label: Text(
                                //           "Re order".tr,
                                //           style:
                                //               TextStyle(color: mainColorGrey),
                                //         ),
                                //       ),
                                //       TextButton.icon(
                                //         onPressed: () {

                                //         },
                                //         icon: Icon(
                                //           Icons.visibility_outlined,
                                //           color: mainColorGrey,
                                //         ), // Add your desired icon
                                //         style: TextButton.styleFrom(
                                //             backgroundColor: Colors.transparent,
                                //             fixedSize: Size(
                                //                 getWidth(context, 30),
                                //                 getHeight(context, 3))),
                                //         label: Text(
                                //           "View".tr,
                                //           style:
                                //               TextStyle(color: mainColorGrey),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
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
