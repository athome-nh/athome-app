import 'package:flutter/material.dart';

import '../Config/property.dart';

class ChooseLang extends StatefulWidget {
  const ChooseLang({super.key});

  @override
  State<ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<ChooseLang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              Image.asset("assets/images/world.png"),
              Container(
                child: Text(
                  "Language",
                  style: TextStyle(
                      fontFamily: mainFontbold,
                      fontSize: 24,
                      color: mainColorGrey),
                ),
              ),
              SizedBox(
                height: getHeight(context, 3),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: mainColorGrey)),
                width: getWidth(context, 80),
                height: getWidth(context, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/flag_kurdish.png"),
                    Text(
                      "Kurdish",
                      style: TextStyle(
                          fontFamily: mainFontbold,
                          fontSize: 14,
                          color: mainColorGrey),
                    ),

                    Icon(Icons.check,color: Colors.green,),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: mainColorGrey)),
                width: getWidth(context, 80),
                height: getWidth(context, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/flag_iraq.png"),
                    Text(
                      "Arabic",
                      style: TextStyle(
                          fontFamily: mainFontbold,
                          fontSize: 14,
                          color: mainColorGrey),
                    ),

                    Icon(Icons.check,color: mainColorWhite,),

                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: mainColorGrey)),
                width: getWidth(context, 80),
                height: getWidth(context, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/flag_english.png"),
                    Text(
                      "English",
                      style: TextStyle(
                          fontFamily: mainFontbold,
                          fontSize: 14,
                          color: mainColorGrey),
                    ),
                    
                    Icon(Icons.check,color: mainColorWhite,),
                  ],
                ),
              ),
            
              

              SizedBox(
                height: getHeight(context, 7),
              ),

              Container(
                padding: EdgeInsets.only(
                                top: getWidth(context, 2),
                                left: getWidth(context, 2),
                                right: getWidth(context, 2),
                                bottom: getWidth(context, 1),
                              ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: mainColorGrey)),
                width: getWidth(context, 35),
                height: getWidth(context, 12),
                child: Center(
                  child: Text(
                        "Get Start",
                        style: TextStyle(
                            fontFamily: mainFontbold,
                            fontSize: 14,
                            color: mainColorGrey),
                      ),
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
