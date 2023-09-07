import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Config/property.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Language",
          style: TextStyle(
              color: mainColorGrey, fontFamily: mainFontMontserrat4, fontSize: 20),
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
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [

            SizedBox(
                  height: getHeight(context, 1),
                ),

                GestureDetector(
                  onTap: () { },
                  child: Container(
                    width: getWidth(context, 85),
                    height: getHeight(context, 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: mainColorLightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: getHeight(context, 2),
                                color: mainColorRed,
                              ),
                              SizedBox(width: getWidth(context, 4),),
                              Text(
                                "English",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: mainFontMontserrat4,
                                    color: mainColorGrey),
                              ),
                              
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:getWidth(context, 7),),
                          child: Icon(
                            FontAwesomeIcons.language,
                            color: mainColorRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: getHeight(context, 3),
                ),

                GestureDetector(
                  onTap: () { },
                  child: Container(
                    width: getWidth(context, 85),
                    height: getHeight(context, 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: mainColorLightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: getHeight(context, 2),
                                color: mainColorGrey,
                              ),
                              SizedBox(width: getWidth(context, 4),),
                              Text(
                                "English",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: mainFontMontserrat4,
                                    color: mainColorGrey),
                              ),
                              
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:getWidth(context, 7),),
                          child: Icon(
                            FontAwesomeIcons.language,
                            color: mainColorGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: getHeight(context, 3),
                ),

                GestureDetector(
                  onTap: () { },
                  child: Container(
                    width: getWidth(context, 85),
                    height: getHeight(context, 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: mainColorLightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: getHeight(context, 2),
                                color: mainColorGrey,
                              ),
                              SizedBox(width: getWidth(context, 4),),
                              Text(
                                "English",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: mainFontMontserrat4,
                                    color: mainColorGrey),
                              ),
                              
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:getWidth(context, 7),),
                          child: Icon(
                            FontAwesomeIcons.language,
                            color: mainColorGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: getHeight(context, 15),
                ),

                Image.asset(
                  'assets/images/world.png',
                ),


            
          ],
        ),
      ),
    );
  }
}