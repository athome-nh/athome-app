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
import 'package:line_icons/line_icons.dart';
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
                ],
              )
            : ListView.builder(
                itemCount: productrovider.location.length,
                itemBuilder: (BuildContext context, int index) {
                  final location = productrovider.location[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: lang == "en"
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      children: [
                        Stack(
                          alignment: lang == "en"
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: mainColorGrey2.withOpacity(0.5),
                                    ),
                                    color: mainColorlightGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        width: getWidth(context, 40),
                                        height: getHeight(context, 14),
                                        "assets/images/Map.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: RichText(
                                        text: TextSpan(
                                          text: location.type.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: mainColorGrey,
                                              fontFamily: mainFontbold),
                                          children: <TextSpan>[
                                            TextSpan(text: "\n"),
                                            new TextSpan(
                                              text:
                                                  "Location: " + location.area!,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: mainColorRed,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: mainFontnormal),
                                            ),
                                            TextSpan(text: "\n"),
                                            new TextSpan(
                                              text: location.name!,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: mainColorBlack,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: mainFontnormal),
                                            ),
                                            TextSpan(text: "\n"),
                                            new TextSpan(
                                              text: location.phone!,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: mainColorBlack,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: mainFontnormal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            GestureDetector(
                              onTap: productrovider.defultlocation ==
                                      location.id
                                  ? null
                                  : () {
                                      var data = {"id": location.id!};
                                      Network(false)
                                          .postData(
                                              "delete_location", data, context)
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Ionicons.trash_bin_outline,
                                  color: productrovider.defultlocation ==
                                          location.id
                                      ? mainColorGrey2.withOpacity(0.8)
                                      : mainColorRed,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            productrovider.setdefultlocation(location.id!);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    productrovider.defultlocation == location.id
                                        ? "Selected"
                                        : "Selecte",
                                    style: TextStyle(
                                        color: mainColorBlack,
                                        fontFamily: mainFontnormal,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    productrovider.defultlocation != location.id
                                        ? Icons.circle_outlined
                                        : Icons.circle_rounded,
                                    color: mainColorGrey,
                                    size: 22,
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
