import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/map/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class location_screen extends StatefulWidget {
  const location_screen({super.key});

  @override
  State<location_screen> createState() => _location_screenState();
}

class _location_screenState extends State<location_screen> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          backgroundColor: mainColorWhite,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),
          centerTitle: true,
          title: Text(
            "Locations",
            style: TextStyle(
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getHeight(context, 80),
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
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: mainColorLightGrey,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Container(
                                    height: getHeight(context, 12),
                                    width: getWidth(context, 100),
                                    child: GoogleMap(
                                      zoomGesturesEnabled: false,
                                      zoomControlsEnabled: false,
                                      scrollGesturesEnabled: false,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(location.latitude!,
                                            location.longitude!),
                                        zoom:
                                            19.0, // Adjust the zoom level as needed
                                      ),
                                      markers: {
                                        Marker(
                                          markerId: MarkerId('location_marker'),
                                          position: LatLng(location.latitude!,
                                              location.longitude!),
                                          infoWindow: InfoWindow(
                                            title: 'Location',
                                          ),
                                        ),
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      location.name!,
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontSize: 14,
                                          fontFamily: mainFontbold),
                                    ),
                                    subtitle: Text(
                                      location.area!,
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontSize: 14,
                                          fontFamily: mainFontnormal),
                                    ),
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
                                                    .deletelocation(
                                                        location.id!);
                                                toastShort(
                                                    "Delete location success");
                                              }
                                            }
                                          });
                                        },
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              color: mainColorRed,
                                              fontFamily: mainFontnormal),
                                        )),
                                  ),
                                ],
                              ),
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
