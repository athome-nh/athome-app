import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Config/property.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  bool isExpanded = false;

  void _toggleBottomSheet() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = true;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: isExpanded
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.height * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          // logo
                          isExpanded
                              ? SizedBox()
                              : Padding(
                                  padding: EdgeInsets.only(
                                    top: getHeight(context, isExpanded ? 2 : 4),
                                  ),
                                  child: Image.asset(
                                    'assets/images/Logo-Type-2.png',
                                    width: getWidth(context, 25),
                                  ),
                                ),

                          SizedBox(
                            height: getHeight(context, isExpanded ? 2 : 5),
                          ),

                          // Text Question
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 6)),
                            child: isExpanded
                                ? Text(
                                    "Text Fullll Aram and Mohamad".tr,
                                    style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.justify,
                                  )
                                : Text(
                                    "Text Niwaaa".tr,
                                    style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                          ),

                          SizedBox(
                            height: getHeight(context, isExpanded ? 2 : 5),
                          ),

                          // Rating
                          RatingBar(
                            filledIcon: Icons.favorite,
                            emptyIcon: Icons.favorite_border,
                            onRatingChanged: (value) => (
                              {
                                setState(() {
                                  isExpanded = true;
                                }),
                              },
                            ),
                            initialRating: 0,
                            alignment: Alignment.center,
                            filledColor: mainColorRed,
                            emptyColor: mainColorRed,
                            size: 50,
                          ),

                          SizedBox(
                            height: getHeight(context, isExpanded ? 2 : 5),
                          ),

                          // Full Expanded
                          isExpanded
                              ? Column(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Column(
                                        children: [
                                          // Text Good
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getWidth(context, 6)),
                                            child: Text(
                                              "Good".tr,
                                              style: TextStyle(
                                                color: mainColorBlack,
                                                fontFamily: mainFontnormal,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),

                                          SizedBox(
                                            height: getHeight(context, 5),
                                          ),

                                          // Text Options
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getWidth(context, 6)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: mainColorGrey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Option One".tr,
                                                      style: TextStyle(
                                                        color: mainColorBlack,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: mainColorGrey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Option Two".tr,
                                                      style: TextStyle(
                                                        color: mainColorBlack,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: mainColorGrey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Option Three".tr,
                                                      style: TextStyle(
                                                        color: mainColorBlack,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(
                                            height: getHeight(context, 7),
                                          ),

                                          // Text Good
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getWidth(context, 6)),
                                            child: TextFormField(
                                              maxLines: 6,
                                              initialValue: 'Enter your text',
                                              decoration: InputDecoration(
                                                labelText: 'Note',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        16.0), // Set the border radius for all corners
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getWidth(context, 4)),
                                            child: TextButton(
                                              onPressed: () async {},
                                              style: TextButton.styleFrom(
                                                fixedSize: Size(
                                                    getWidth(context, 90),
                                                    getHeight(context, 6)),
                                              ),
                                              child: Text(
                                                "Checkout".tr,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: getHeight(context, 3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        isExpanded = false;
      });
    });
  }

// page
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bottom Sheet Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => _showBottomSheet(context),
            child: Text('Show Bottom Sheet'),
          ),
        ),
      ),
    );
  }
}
