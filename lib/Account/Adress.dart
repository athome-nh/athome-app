import 'package:athome/Config/property.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Saved Address".tr,
          style: TextStyle(
              color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
        ),
        centerTitle: true,
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

        // Change the color of the unselected tab labels
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: getHeight(context, 70),
                width: getWidth(context, 100),
                child: ListView.builder(
                    itemCount: 3, // Number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 5,
                          child: Container(
                              width: getWidth(context, 100),
                              height: getHeight(context, 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  trailing: TextButton(
                                      onPressed: () {},
                                      child: Text("Change",
                                          style: TextStyle(
                                            color: mainColorRed,
                                            fontFamily: mainFontnormal,
                                          ))),
                                  leading: CachedNetworkImage(
                                    imageUrl: "assets/images/402.png",
                                    width: getWidth(context, 15),
                                    height: getHeight(context, 7),
                                  ),
                                  title: Text(
                                    "Address 1",
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontFamily: mainFontnormal,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    "Erbil,italian city 1,house 646",
                                    style: TextStyle(
                                        color: mainColorGrey.withOpacity(0.5),
                                        fontFamily: mainFontnormal,
                                        fontSize: 12),
                                  ),
                                ),
                              )),
                        ),
                      );
                    })),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: getHeight(context, 7),
                width: getWidth(context, 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffF2F2F2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Ionicons.location,
                      color: mainColorRed,
                    ),
                    Text(
                      "Add your New address".tr,
                      style: TextStyle(
                          color: mainColorGrey,
                          fontFamily: mainFontnormal,
                          fontSize: 16),
                    ),
                    Icon(
                      Ionicons.add,
                      color: mainColorGrey,
                      size: 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
