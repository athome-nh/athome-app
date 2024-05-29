import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

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

  List<String> ratestar = [
    'Poor',
    'Terrible',
    'Awful',
    'Unacceptable',
    'Dismal'
  ];
  List<String> oneStar = [
    'Poor',
    'Terrible',
    'Awful',
    'Unacceptable',
    'Dismal'
  ];
  List<String> twoStar = [
    'Below Average',
    'Mediocre',
    'Subpar',
    'Disappointing',
    'Unsatisfactory'
  ];
  List<String> threeStar = [
    'Average',
    'Decent',
    'Fair',
    'Okay',
    'Satisfactory'
  ];
  List<String> fourStar = [
    'Good',
    'Great',
    'Very Good',
    'Impressive',
    'Praiseworthy'
  ];
  List<String> fiveStar = [
    'Excellent',
    'Outstanding',
    'Exceptional',
    'Superb',
    'Flawless'
  ];
  List<String> getDisplayedWords(double i) {
    switch (i) {
      case 1:
        return oneStar;
      case 2:
        return twoStar;
      case 3:
        return threeStar;
      case 4:
        return fourStar;
      case 5:
        return fiveStar;
      default:
        return [];
    }
  }

  List<Widget> elem(StateSetter setState) {
    List<Widget> txt = [];

    for (var element in displayedWords) {
      bool isSelected = selectedWords.contains(element);
      txt.add(GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              isSelected = !isSelected;
              selectedWords.remove(element);
            } else {
              isSelected = !isSelected;
              selectedWords.add(element);
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: isSelected ? mainColorGrey : Colors.transparent,
              border:
                  Border.all(width: 1, color: mainColorBlack.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.only(
            top: 6,
            bottom: 6,
            left: 10,
            right: 10,
          ),
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 10,
            top: 10,
          ),
          child: Text(
            element,
            style: TextStyle(
              fontFamily: mainFontnormal,
              color:
                  isSelected ? mainColorWhite : mainColorBlack.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ),
      ));
    }
    return txt;
  }

  TextEditingController feedbackController = TextEditingController();
  List<String> selectedWords = [];
  int? selectedRating;
  List<String> displayedWords = [];
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: isExpanded
                    ? MediaQuery.of(context).size.height - 50
                    : MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Directionality(
                    textDirection:
                        lang == "en" ? TextDirection.ltr : TextDirection.rtl,
                    child: Stack(
                      alignment:
                          lang == "en" ? Alignment.topRight : Alignment.topLeft,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: getHeight(context, 4),
                            ),
                            isExpanded
                                ? SizedBox()
                                : Image.asset(
                                    'assets/images/Dlly Las Main.png',
                                    width: getWidth(context, 25),
                                  ),

                            SizedBox(
                              height: getHeight(context, 2),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 6)),
                              child: Text(
                                isExpanded
                                    ? "Custom rating bar for flutter with support of: custom icons, half icons, directions, alignments & more."
                                        .tr
                                    : "Custom rating bar for flutter with support of: custom icons, half icons, directions, alignments & more."
                                        .tr,
                                style: TextStyle(
                                  color: mainColorBlack,
                                  fontFamily: mainFontnormal,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(
                              height: getHeight(context, 2),
                            ),

                            // Rating
                            RatingBar(
                              filledIcon: LineIcons.starAlt,
                              emptyIcon: LineIcons.star,
                              key: Key('rating_bar'), // Adding the key here
                              onRatingChanged: (value) {
                                setState(() {
                                  selectedRating = int.parse(
                                      value.toString().substring(0, 1));
                                  isExpanded = true;
                                  selectedWords.clear();
                                  displayedWords = getDisplayedWords(value);
                                });
                              },

                              initialRating: 0,
                              alignment: Alignment.center,
                              // filledColor: mainColorRed,
                              // emptyColor: mainColorRed,
                              size: 50,
                            ),
                            SizedBox(
                              height: getHeight(context, 2),
                            ),
                            isExpanded
                                ? Text(
                                    ratestar[selectedRating! - 1],
                                    style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : SizedBox(),
                            isExpanded
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: getHeight(context, 3),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        children: elem(setState),
                                      ),
                                      SizedBox(
                                        height: getHeight(context, 4),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: TextFormField(
                                          maxLines: 3,
                                          controller: feedbackController,
                                          cursorColor: mainColorGrey,
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {},
                                          validator: (value) {
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color:
                                                    mainColorGrey, // Customize border color
                                                width:
                                                    1.0, // Customize border width
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: mainColorGrey.withOpacity(
                                                    0.5), // Customize border color
                                                width:
                                                    1.0, // Customize border width
                                              ),
                                            ),
                                            labelText: "Feedback",
                                            labelStyle: TextStyle(
                                                color: mainColorGrey
                                                    .withOpacity(0.8),
                                                fontSize: 20,
                                                fontFamily: mainFontbold),
                                            hintText: "Add your Feedback",
                                            hintStyle: TextStyle(
                                                color: mainColorBlack
                                                    .withOpacity(0.5),
                                                fontSize: 14,
                                                fontFamily: mainFontnormal),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(context, 20),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: getWidth(context, 4)),
                                        child: TextButton(
                                          onPressed: () async {},
                                          style: TextButton.styleFrom(
                                            fixedSize: Size(
                                                getWidth(context, 90),
                                                getHeight(context, 6)),
                                          ),
                                          child: Text(
                                            "Send Feedback",
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: mainColorGrey,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
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
